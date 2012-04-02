# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://jashkenas.github.com/coffee-script/

$(document).ready ->
  $("#modal-wrap").delegate ".lang.btn", "click", () ->
    changeModalFormLanguage = (forms_container, locale) ->
      forms_container.find('.localized').hide()
      forms_container.find(".localized.#{locale}").show()
      forms_container.find('.lang.btn').toggleClass('active', false)
      forms_container.find(".lang.btn[hreflang='#{locale}']").toggleClass('active', true)

    changeModalFormLanguage $(this).parents('.content:first'), $(this).attr('hreflang')

  $("#modal-wrap").delegate "select", "change", () ->
    select = $(this)
    organization_id = select.val()
    select.nextAll().remove()

    $.get $("#modal-wrap .modal").attr('data-url'), (organizations) ->
      children = _(organizations).filter((org) -> org.parent_id == organization_id)
      if children.length > 0
        template = $($("#organization-select-template").html())
        select.parents('.inline-block:first').append template
        template.render(children, item: -> value: "#{@_id}", text: "#{@name}")
        default_option = select.children('option').first().clone().attr('selected', 'selected')
        template.prepend(default_option).uniform()

    return false

  uniformify('body')

###
openNewOrganDialog = ->
  $("#modal-wrap").show()
  $("#create-new-organ").fadeIn('fast')

closeNewOrganDialog = ->
  $("#create-new-organ").fadeOut('fast')
  $("#modal-wrap").hide()

index = ->

newOrgan = ->
  openNewOrganDialog()

$(document).ready ->
  $("select, input:checkbox, input:radio, input:file, input:text, textarea, submit").uniform()

  $("#sidebar a.create-new-organ").click () ->
    router.setRoute '/organ/new'
    return false

  $("#create-new-organ a.close-modal").click () ->
    router.setRoute '/'
    return false

  $("#create-new-organ select").change () ->
    organization_id = $(this).val()
    $.get "organizations.json", (organizations) ->
      children = _(organizations).filter((org) -> org.parent_id == organization_id)
      if children.length > 0

    return false

  $("#single-organ a.application-call").click () ->
    $("#modal-wrap").show()
    $("#call-for-application").fadeIn('fast')
    return false

  $("#call-for-application a.close-modal").click () ->
    $("#call-for-application").fadeOut('fast')
    $("#modal-wrap").hide()
    return false

  $("#single-organ .member-card").click () ->
    $("#modal-wrap").show()
    $("#received-application").fadeIn('fast')
    return false

  $("#received-application a.close-modal").click () ->
    $("#received-application").fadeOut('fast')
    $("#modal-wrap").hide()
    return false

  $("#single-organ a.send-message").click () ->
    $("#modal-wrap").show()
    $("#send-group-message").fadeIn('fast')
    return false

  $("#send-group-message a.close-modal").click () ->
    $("#send-group-message").fadeOut('fast')
    $("#modal-wrap").hide()
    return false

  $("#single-call a.send-application").click () ->
    $("#modal-wrap").show()
    $("#send-application").fadeIn('fast')
    return false

  $("#send-application a.close-modal").click () ->
    $("#send-application").fadeOut('fast')
    $("#modal-wrap").hide()
    return false

  $('.tab-content').each ->
    $(this).children(':gt(0)').hide()

  $('.tabs-list li a').click ->
    tab = $(this).parents('.tabs').siblings('.tab-content').children('.tab').eq($(this).parent().index())
    if tab.length > 0
      tab.show().siblings().hide()
      $(this).parent().addClass('active').siblings().removeClass 'active'
      tab.trigger('tabActivated')
    false


  router = Router(
    "" : index
    "/organ/new" :
      on:    newOrgan
      after: closeNewOrganDialog
  )

  router.init()
###
