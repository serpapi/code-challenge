# SERP API Code Challenge

This document provides a solution to the SERP API Code Challenge. The original challenge description can be found [here](#).

## Solution Overview

The core idea of the solution is to implement a scraper that employs multiple strategies for parsing the image gallery displayed at the top of the search results page. Since Google may return different results for similar queries each strategy relies on specific selectors and is encapsulated within its own class.

### Supported Cases

The solution currently handles the following cases:
- **Van Gogh Paintings** (challenge case)
- **List of Popes**
- **Red Hot Chili Peppers Members**
- **Van Gogh Paintings** (new request)

### Notes

*The solution may not cover all potential gallery types, as there appear to be many variations. However, it effectively handles the listed cases and is designed to be extensible for future cases.*
