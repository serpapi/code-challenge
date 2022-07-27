package com.github.mfulbright.serpapicodechallenge;

import com.fasterxml.jackson.databind.JsonNode;
import com.fasterxml.jackson.databind.ObjectMapper;
import com.fasterxml.jackson.databind.node.ArrayNode;
import com.fasterxml.jackson.databind.node.ObjectNode;
import org.jsoup.Jsoup;
import org.jsoup.nodes.Document;
import org.jsoup.nodes.Element;
import org.jsoup.select.Elements;

import java.io.File;
import java.io.IOException;
import java.util.HashMap;
import java.util.Map;
import java.util.regex.Matcher;
import java.util.regex.Pattern;

public class Main {
    public static void main(String[] args) throws IOException {
        ObjectMapper objectMapper = new ObjectMapper();

        JsonNode artworks = parseHtml(objectMapper, "resources/van-gogh-paintings.html");

        File expectedArtworksFile = new File("resources/expected-artworks.json");
        JsonNode expectedArtworks = objectMapper.readTree(expectedArtworksFile);

        System.out.println(artworks.equals(expectedArtworks));
    }

    private static JsonNode parseHtml(
            ObjectMapper objectMapper,
            String inputFileName) throws IOException {
        File htmlFile = new File(inputFileName);
        Document document = Jsoup.parse(
                htmlFile,
                null,
                "https://www.google.com");

        // The actual image sources we want to capture are not contained in the
        // img tags themselves, but stored in JS in another part of the
        // document. Parse them and build a map from it, to be used later.
        Map<String, String> imageIdsToSrc = parseImageIdsToSrcs(document);

        // Create the JSON nodes we'll be returning.
        ObjectNode resultNode = objectMapper.createObjectNode();
        ArrayNode artworksNode = objectMapper.createArrayNode();
        resultNode.set("artworks", artworksNode);

        // Start walking down the DOM to find the nodes related to the carousel
        // that we need.
        Elements newCarouselElements =
                document.getElementsByTag("g-scrolling-carousel");
        Element newCarouselElement = newCarouselElements.first();
        // The content div should be the 0th child of the carousel, but we'll
        // filter out buttons and script children first to be safer.
        Element carouselContent = newCarouselElement
                .children()
                .stream()
                .filter(e -> !e.tagName().matches(".*button.*|script"))
                .findFirst()
                .orElseThrow();
        // The next child down is the container for all the carousel items
        Element itemsContainer = carouselContent.child(0);

        for (Element carouselItem : itemsContainer.children()) {
            ObjectNode childJson = objectMapper.createObjectNode();

            // Find the anchor tag within the carousel item
            Element anchorElement = carouselItem.getElementsByTag("a").first();
            childJson.put("name", anchorElement.attr("aria-label"));

            // If the carousel item has a subtitle/extension, it's contained
            // within the second child of the anchor tag.
            Element itemTextDiv = anchorElement.child(1);
            if (itemTextDiv.childrenSize() > 1) {
                Element subtitleTextDiv = itemTextDiv.child(1);
                String subtitleText = subtitleTextDiv.text();

                ArrayNode extensionsNode = objectMapper.createArrayNode();
                extensionsNode.add(subtitleText);
                childJson.put("extensions", extensionsNode);
            }

            childJson.put("link", anchorElement.attr("abs:href"));

            Element imageElement =
                    anchorElement.getElementsByTag("img").first();
            String imageId = imageElement.attr("id");
            childJson.put("image", imageIdsToSrc.get(imageId));

            artworksNode.add(childJson);
        }

        return resultNode;
    }

    private static Map<String, String> parseImageIdsToSrcs(Document document) {
        Elements scriptElements = document.getElementsByTag("script");
        Element imageSrcScript = scriptElements
                .stream()
                .filter(element -> element.data().contains("_setImagesSrc"))
                .findFirst()
                .orElseThrow();
        String[] imageSrcScriptPieces = imageSrcScript
                .data()
                .split("_setImagesSrc");

        Map<String, String> imageIdsToSrc = new HashMap<>();
        // Build a regex to parse image srcs and Ids. This will match snippets
        // of JS like:
        // 'data:image/jpeg;base64,...';var ii=['kximg0']
        // Which is used to set the src of image kximg0 to the base64 src at
        // the beginning of the match.
        Pattern imageSrcPattern = Pattern.compile(
                "'(data:image/[^']+)'.*var\\s+\\w+\\s*=\\s*\\['(.*)'\\]");
        for (String imageSrcScriptPiece : imageSrcScriptPieces) {
            Matcher pieceMatcher = imageSrcPattern.matcher(imageSrcScriptPiece);
            if (pieceMatcher.find()) {
                imageIdsToSrc.put(
                        pieceMatcher.group(2),
                        pieceMatcher.group(1).replaceAll("\\\\", ""));
            }
        }
        return imageIdsToSrc;
    }
}