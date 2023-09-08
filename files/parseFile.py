import re
import time
import json


def parseFile(fileName):
    startTime = int(time.time())

    file = open(fileName, "r")
    doc = file.read()

    # Parsing the data to find the scrolling carousels
    patternScroll = re.compile(
        r"<g-scrolling-carousel[^>]*>.*?</g-scrolling-carousel", re.S
    )
    scrollingCarousels = re.findall(patternScroll, doc)

    # Removing the carousels holding inner cards as they weren't standard for the carousels intended
    for bar in scrollingCarousels:
        if "<g-inner-card" in bar:
            scrollingCarousels.remove(bar)

    # Finding the javascript code that sets images' src
    patternScript = re.compile(r"<script.*?>(.*?)</script", re.S)
    scripts = re.findall(patternScript, doc)
    imageScript = ""
    for script in scripts:
        if "_setImagesSrc" in script:
            imageScript = script

    # Creating regex patterns for parsing
    patternAnchor = re.compile(r"<a[^>]*>.*?</a", re.S)
    patternName = re.compile(r"title=\"(.*?)\"", re.S)
    patternExArr = re.compile(r"ellip.*?>\s*(.*?)\s*</", re.S)
    patternLink = re.compile(r"href=\"(.*?)\"")
    patternID = re.compile(r"<img.*id=\"(.*?)\"", re.S)

    # Tracking how many carousels we have
    count = 0

    # Running through each scrolling carousel to get the required data
    for bar in scrollingCarousels:
        # Finding all the anchors with each items information
        anchors = re.findall(patternAnchor, bar)

        # Getting the name, extension array, link and image for each item
        carouselItems = []
        for anchor in anchors:
            if "title" and "img" not in anchor:
                continue
            name = re.findall(patternName, anchor)
            item = {
                "name": name[0],
            }

            exArray = re.findall(patternExArr, anchor)
            if len(exArray) != 0:
                item["extensions"] = exArray

            # Check that the extension is not in title
            if (exArray) and (item.get("extensions")[0] in item.get("name")):
                strRemove = " ({0})".format(item.get("extensions")[0])
                item["name"] = item.get("name").replace(strRemove, "")

            link = re.findall(patternLink, anchor)
            item["link"] = "https://www.google.com" + link[0]

            id = re.findall(patternID, anchor)
            if id:
                patternImage = r"var\s+s\s*=\s*'([^']+)';\s*var\s+ii\s*=\s*\[\'{0}\'\];".format(
                    id[0]
                )
                image = re.findall(patternImage, imageScript, re.S)
                if len(image) != 0:
                    item["image"] = image[0]
            if "image" not in item:
                item["image"] = None

            carouselItems.append(item)

        # Exporting the resulting data to a JSON file
        fNames = fileName.split("/")
        work = fNames[1].removesuffix(".html")
        outputFile = open("result-%s-%d.json" % (work, count), "w")
        json.dump(carouselItems, outputFile)
        outputFile.close()
        print("Resulting array exported to 'resulted-%s-%d.json' file." % (work, count))

        # Determining the runtime of the program
        endTime = int(time.time())
        print("Program completed in %d seconds." % (endTime - startTime))

        count += 1
    file.close()