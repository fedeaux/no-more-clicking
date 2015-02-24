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
    $('input, textarea, select', @form).each (i, _input) =>
      @fillInput $ _input

  submitForm: =>
    @form.submit()

  fillInput: (input) =>

    if input.is(':checkbox') and not input.prop('disabled')
      input.prop('checked', @flipCoin()).change()

    else if input.is('textarea') and not input.prop('disabled')
      if faker
        input.text(faker.lorem.paragraph()).change()

      else
        input.text('Lorem Ipsum Avec Danut').change()

    else if input.is(':text') and not input.prop('disabled')
      if faker
        @fillTextInput input
      else
        input.val('Lorem Ipsum').change()

    else if input.is('select') and not input.prop('disabled')
      options = $ 'option', input
      options.eq(Math.floor(Math.random() * options.length)).prop 'selected', true
      input.change()

  fillTextInput: (input) =>
    name = input.attr 'name'

    if name.match /name/
      input.val faker.name.findName()

    else if name.match /ddd|ddi|ramal/
      input.val faker.random.number(89) + 10

    else if name.match /prefix|suffix/
      input.val faker.random.number(8999) + 1000

    else if name.match /\[email\]/
      input.val faker.internet.email()

    else
      input.val faker.lorem.words(1)

    input.change()

  flipCoin: ->
    Math.floor(Math.random() + .5) == 1
