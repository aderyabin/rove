#= require jquery
#= require bootstrap

toggle = (element, nesting=0) ->
  switcher = element.attr('data-switcher')
  selector = element.attr('data-selector')
  group    = $("[data-group=#{switcher}]")

  if element.is(':checked')
    group.slideDown()
  else
    group.slideUp()

  if nesting is 0 && element.is('[type=radio]')
    $("[data-selector=#{selector}]").each -> toggle $(this), nesting+1

filter = (element) ->
  category = element.attr('data-category')
  needle   = element.val()

  $(".category[data-category=#{category}]").each ->
    element = $(this)

    if needle.length == 0 || new RegExp('^'+needle, 'i').test(element.find('span').text())
      element.slideDown()
    else
      element.slideUp()

$ ->
  $('[data-switcher]').click -> toggle $(this)
  $('input[data-category]').keyup -> filter $(this)