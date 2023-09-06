package org.example

import org.json.JSONArray
import org.json.JSONObject
import org.jsoup.Jsoup
import org.jsoup.nodes.Document
import org.jsoup.nodes.Element
import org.jsoup.nodes.TextNode
import org.jsoup.select.Elements
import java.io.File

class Parser {

  fun Elements.second(): Element? = if (size < 2) null else this[1]

  fun cleanImage(base64: String): String = base64.removePrefix("'").removeSuffix("';")

  fun getImageSrcFromId(scriptSourceText: String, id: String): String {
    val start = "var ii=['${id}']"
    if (!scriptSourceText.contains(start)) {
      return ""
    }
    return scriptSourceText
      .substringBefore("var ii=['${id}']")
      .substringAfterLast("(function(){var s=")
      .removeSuffix(";var ii=['dimg_91'];_setImagesSrc(ii,s);})();")
  }

  fun scriptSourceText(doc: Document): String {
    return doc.getElementsByAttributeValue("nonce", "lOsRZRlq+Dr1LlZhVtLxFg==")
      .map { it.data() }
      .first { it.contains("setImagesSrc") }
  }

  fun parse(input: File = File("./van-gogh-paintings.html"), outputFile: File = File("./out.json")): JSONObject {
    val output = JSONObject()
    val imageArray = JSONArray()

    val doc: Document = Jsoup.parse(input, "UTF-8", "http://www.google.com")

    val scriptSourceText = scriptSourceText(doc)
    val carousel: Element = doc.getElementsByTag("g-scrolling-carousel").first() ?: return JSONObject()
    val scrollWrapper = carousel.getElementsByClass("EDblX DAVP1").first() ?: return JSONObject()

    for (scwChild in scrollWrapper.children()) {
      val imageItem = scwChild.getElementsByTag("a").first()
      val imageName = imageItem?.attr("aria-label") ?: "couldn't get the aria label attribute"
      val extensionLine: String? = (imageItem?.children()?.second()?.children()?.second()?.childNodes()?.first() as TextNode?)?.text()
      val imageId = imageItem?.getElementsByTag("img")?.first()?.id() ?: "no-id"

      val item = JSONObject()
      imageArray.put(item)

      item.put("name", imageName)
      item.put("image", cleanImage(getImageSrcFromId(scriptSourceText, imageId)))
      item.put("link", "https://www.google.com" + imageItem?.attr("href"))

      if (!extensionLine.isNullOrEmpty()) item.put("extensions", JSONArray().put(extensionLine))
    }

    output.put("artworks", imageArray)
    outputFile.writeText(output.toString(2))
    return output
  }
}