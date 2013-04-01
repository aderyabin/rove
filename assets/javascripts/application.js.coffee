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


$ ->
  $('[data-switcher]').click -> toggle $(this)
