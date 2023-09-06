package org.example

import org.json.JSONObject
import org.junit.Test
import java.io.File
import kotlin.math.exp
import kotlin.test.assertEquals

class HelloTest {
  @Test
  fun test() {
    val parsed = Parser().parse()
    val expectedText = File("expected-array.json").readText()
    val expectedJson = JSONObject(expectedText)
    println(parsed.toMap() == expectedJson.toMap())
  }
}
