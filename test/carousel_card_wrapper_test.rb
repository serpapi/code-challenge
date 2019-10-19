require File.expand_path '../../carousel_card_wrapper.rb', __FILE__
require 'minitest/autorun'


class CarouselCardWrapperTest < Minitest::Test
  def wrapper
    content = File.read('./test/page_examples/animals-as-leaders-albums.html')
    card = Nokogiri::HTML(content).css('.klitem-tr').first
    CarouselCardWrapper.new(card, content)
  end

  def test_title
    assert_equal 'Animals As Leaders Live 2017', wrapper.title
  end

  def test_extentions
    assert_equal ["2018"], wrapper.extentions
  end

  def test_link
    assert_equal card_link, wrapper.link
  end

  def test_image
    assert_equal image_base64, wrapper.image
  end

  def card_link
    <<~HEREDOC.gsub(/\n/, '')
    https://www.google.com/search?q=Animals+as+Leaders+Animals+As+Leaders+Live+2
    017&stick=H4sIAAAAAAAAAONgFuLSz9U3MDOON83NUOLVT9c3NEw3MK-qsijI0xLPTrbSzy0tzk
    zWTywqySwusUrMSSrNLX7EGMYt8PLHPWEp30lrTl5jdOfCpVJIg4vNNa8ks6RSSI6LTwrJLg0GKR
    4uJL4VkwYTzyJWfce8zNzEnGKFxGIFn9TElNSiYgWYkCNCyCezLFXByMDQHADCq47kwQAAAA&nps
    ic=0&sa=X&ved=0ahUKEwjInr_w46flAhUB0aYKHQmfDFMQ-BYIMzAs
    HEREDOC
  end

  def image_base64
    <<~HEREDOC.gsub(/\n/, '')
    data:image/jpeg;base64,/9j/4AAQSkZJRgABAQAAAQABAAD/2wCEAAkGBwgHBgkIBwgKCgkLD
    RYPDQwMDRsUFRAWIB0iIiAdHx8kKDQsJCYxJx8fLT0tMTU3Ojo6Iys/RD84QzQ5OjcBCgoKDQwNG
    g8PGjclHyU3Nzc3Nzc3Nzc3Nzc3Nzc3Nzc3Nzc3Nzc3Nzc3Nzc3Nzc3Nzc3Nzc3Nzc3Nzc3Nzc3N
    //AABEIAHgAeAMBIgACEQEDEQH/xAAbAAEAAgMBAQAAAAAAAAAAAAAAAQIDBAYFB//EADgQAAIBA
    gQCCAMHAwUAAAAAAAABAgMRBBIhMVFhFCJBU3GBkZIFE1QjYpOh0eHwQlLxBhUyM0T/xAAXAQEBA
    QEAAAAAAAAAAAAAAAAAAQIE/8QAFhEBAQEAAAAAAAAAAAAAAAAAABEB/9oADAMBAAIRAxEAPwD6u
    ADnAAAAAFAAEAAAAAUAAAABAABQAAL8m9OxDtSs9dAHotEBCadrX1tujT+diHh3i1NKKTmqXy9HH
    XRvfNZeGuxsyqSS/wCqbd2rK3D9reZh6PSnO7o1UnO7hneRvfNlvbcLjavqlZ68iFLlLs7OJT5kt
    Pspu7s9tOZenJygpOLi2tmET6gAAAAgAAoAAAAem4DV7Fsr5GCddR22KPEsIzt5SFOLdr2fA1ukd
    jNfEVVL/j+RR6YNTA4r58JRm/tIPXmuxmdVVmSlpd7kGQB6bgAAAAACgACBhxdT5dK/F2Mxr4+nO
    rhJqmrzXWiuNuz0uBp578/M87F/F8JhqsqVaq4zjuvlzfZfdIvh8Qqi8Tn/APUklDG15u7WWPn1U
    azB0zU27PRmLE4mnhodZ3fAz1pfaSfNmji3QmutShJ80IK/DcbKtjoypWtZ5rPs/lj2Kks0ddmeJ
    8KwzWJj8mOWEFdvh4m/i89WGanWhZcBo9LDYhVKWVu8o6PmZadTr5ZbPY874dpCae6e/EyTqScsu
    VpcbGR6blbwJNdytG7ehkoyzRfBPQDIAAoCbPgxZ8AiATZ8GLPgB4vxPAZMQsRh1ZVH9pHnxXj2n
    L/Hk3jpQqNRpSUHObV8u604vbQ72urxSa5nPYyrCipYjqqa6sJPdXNYM7lGUcyd09TUxGS54+Hx7
    w9NQ+bBwjok5bIy/wC44ee9an70WDcpxp18lKc5N1KizQg2rpcbbJK56M4RjFRWkVtFHm4Sth41l
    OE4Tai/6ttf8m469Oe9SPqBu4dVL5FNRikpNJay8WZWm5q+qvsjWwk6dOE8rXWlq12ma8Z/1b6aM
    zo24tygnKKV+y9zJQbUssYvnwRS/K3kZqEXlb13sQZATZ8GArlbT+9/PMWl970f6nQ9Ew7/APPR/
    DQ6Lh/p6P4aNVHPdZdsvR/qGpJby8bfudD0TD/T0vYh0TD/AE9L8NCjno5/vfmOt25vRnQ9Ew/09
    L2IdFw/cUvw0KOealz9GLS219GdD0Sh3FL2IdEodxS9iFHPWlbt9GQlK+0vRnRdEw/cU/Yh0PD/A
    E9P2IlHPtSX91vBi0vvX8GdB0TD9xT9qI6Hh+4p+1Fo5+KlveXoyett1vRnv9Dw/cU/ah0PD9xT9
    oo5/rL+/wBGDoOh4buKftAo2rchYvYWRkUsLF7XFkUUtyFi4ArYZS2g0ArlFiw8wK2XEWLeRHkQR
    Yhov5EduwFWtQXAENgABsLgABdgFAEgggAALi/MACbohWAAIAAf/9kx3d
    HEREDOC
  end
end

