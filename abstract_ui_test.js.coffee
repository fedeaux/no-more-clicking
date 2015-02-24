@Ui = @Ui or {}
@Ui.Tests = @Ui.Tests or {}

class Ui.Tests.AbstractUiTest
  constructor: (menu_context_selector) ->
    @menuContext = $ menu_context_selector
    @assignHandlers()

  $: (selector) ->
    $ selector, @menuContext

  assignHandlers: =>
    @$('.fill-form').click @fillForm
    @$('.fill-and-submit-form').click @fillAndSubmitForm

  fillAndSubmitForm: =>
    @fillForm()
    @submitForm()

  fillForm: =>
    $('input, select', @form).each @fillInput

  submitForm: =>
    @form.submit()

  fillInput: (i, _input) =>
    input = $ _input

    if input.is(':checkbox') and not input.prop('disabled')
      input.prop('checked', @flipCoin).change()

    else if input.is(':text') and not input.prop('disabled')
      input.val('Lorem Ipsum').change()

    else if input.is('select') and not input.prop('disabled')
      options = $ 'option', input
      options.eq(Math.floor(Math.random() * options.length)).prop 'selected', true
      input.change()

  flipCoin: ->
    Math.floor(Math.random() + .5) == 1
