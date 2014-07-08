class Trix.SelectionObserver
  events = ["DOMFocusIn", "DOMFocusOut", "mousedown", "mousemove", "keydown"]

  constructor: (@element) ->
    @element.addEventListener(event, @refresh) for event in events
    @range = getRange()

  refresh: =>
    requestAnimationFrame =>
      range = getRange()
      unless rangesAreEqual(range, @range)
        @delegate?.selectionDidChange?()
        @range = range

  getRange = ->
    selection = window.getSelection()
    selection.getRangeAt(0) if selection.rangeCount > 0

  rangesAreEqual = (left, right) ->
    left?.startContainer is right?.startContainer and
      left?.startOffset is right?.startOffset and
      left?.endContainer is right?.endContainer and
      left?.endOffset is right?.endOffset