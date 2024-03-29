﻿/**
 * $Id: virtualkeyboard.js 585 2009-03-18 11:37:19Z wingedfox $
 * $HeadURL: https://svn.debugger.ru/repos/jslibs/Virtual%20Keyboard/tags/VirtualKeyboard.v3.6.1/virtualkeyboard.js $
 *
 * Virtual Keyboard.
 *
 * This library is free software; you can redistribute it and/or
 * modify it under the terms of the GNU Lesser General Public
 * License as published by the Free Software Foundation; either
 * version 2.1 of the License, or (at your option) any later version.
 * See http://www.gnu.org/copyleft/lesser.html
 *
 * LGPL licence is applicable when you keep copyrights visible on the keyboard UI.
 *
 * Do not remove this comment if you want to use script!
 *
 * This software is protected by patent No.2009611147 issued on 20.02.2009 by Russian Federal Service for Intellectual Property Patents and Trademarks.
 *
 * @author Ilya Lebedev
 * @copyright 2006-2009 Ilya Lebedev <ilya@lebedev.net>
 * @version $Rev: 585 $
 * @lastchange $Author: wingedfox $ $Date: 2009-03-18 14:37:19 +0300 (Срд, 18 Мар 2009) $
 * @class VirtualKeyboard
 * @constructor
 */
var VirtualKeyboard = new function () {
  var self = this;
  self.$VERSION$ = "3.6.1.585";
  /**
   *  Some configurable stuff
   *
   *  @type Object
   *  @scope private
   */
  var options = {
     'layout' : null
  }
  /**
   *  ID prefix
   *
   *  @type String
   *  @scope private
   */
  var idPrefix = 'kb_b';
  /**
   *  This flag is used to enable or disable keyboard animation
   *  This is very useful in the secure environments, like password input. Controlled by the CSS class on the field
   *
   *  @see cssClasses
   *  @type Boolean
   *  @scope private
   */
  var animate = true;
  /**
   *  list of the control keys to be shown
   *
   *  @type Object
   *  @scope private
   */
  var controlKeys = {14:'backspace'
                    ,15:'tab'
                    ,28:'enter'
                    ,29:'caps'
                    ,41:'shift_left'
                    ,52:'shift_right'
                    ,53:'del'
                    ,54:'ctrl_left'
                    ,55:'alt_left'
                    ,56:'space'
                    ,57:'alt_right'
                    ,58:'ctrl_right'};
  /**
   *  Prefixes for the keys
   *
   *  @type Object
   *  @scope private
   */
  var KEY = {
      'SHIFT' : 'shift'
     ,'ALT'   : 'alt'
     ,'CTRL'  : 'ctrl'
     ,'CAPS'  : 'caps'
  }
  /**
   *  Current keyboard mapping
   *
   *  @type Array
   *  @scope private
   */
  var keymap;

  /**
   *  List of the available mappings
   *
   *  @type Object
   *  @scope private
   */
  var keymaps = {
        'QWERTY Standard'     : "À1234567890m=ÜQWERTYUIOPÛÝASDFGHJKL;ÞZXCVBNM¼¾¿"
       ,'QWERTY Canadian'     : "Þ1234567890m=ÜQWERTYUIOPÛÝASDFGHJKL;ÀZXCVBNM¼¾¿"
       ,'QWERTY Dutch'        : "Þ1234567890Û¿ÜQWERTYUIOPÝ;ASDFGHJKL=ÀZXCVBNM¼¾m"
       ,'QWERTY Estonian'     : "¿1234567890m=ÜQWERTYUIOPÞÛASDFGHJKL;ÀZXCVBNM¼¾Ý"
       ,'QWERTY Greek (220)'  : "À1234567890¿ÛÜQWERTYUIOP=ÝASDFGHJKL;ÞZXCVBNM¼¾m"
       ,'QWERTY Greek (319)'  : "À1234567890¿=ÜQWERTYUIOPÛÝASDFGHJKL;ÞZXCVBNM¼¾m"
       ,'QWERTY Gujarati'     : "À1234567890m=XQWERTYUIOPÛÝASDFGHJKL;ÜZXCVBNM¼¾¿"
       ,'QWERTY Italian'      : "Ü1234567890ÛÝ¿QWERTYUIOP;=ASDFGHJKLÀÞZXCVBNM¼¾m"
       ,'QWERTY Kannada'      : "À1234567890m=ZQWERTYUIOPÛÝASDFGHJKL;ÞZXCVBNM¼¾¿"
       ,'QWERTY Portuguese'   : "À1234567890ÛÝ¿QWERTYUIOP=;ASDFGHJKLÞÜZXCVBNM¼¾m"
       ,'QWERTY Scandinavian' : "Ü1234567890=Û¿QWERTYUIOPÝ;ASDFGHJKLÀÞZXCVBNM¼¾m"
       ,'QWERTY Spanish'      : "Ü1234567890mÛ¿QWERTYUIOPÝ;ASDFGHJKLÀÞZXCVBNM¼¾ß"
       ,'QWERTY Tamil'        : "À1234567890m =ZQWERTYUIOPÛÝASDFGHJKL;ÞCVBNM¼¾ ¿"
       ,'QWERTY Turkish'      : "À1234567890ßm¼QWERTYUIOPÛÝASDFGHJKL;ÞZXCVBNM¿Ü¾"
       ,'QWERTY UK'           : "ß1234567890m=ÞQWERTYUIOPÛÝASDFGHJKL;ÀZXCVBNM¼¾¿"
       ,'QWERTZ Albanian'     : "À1234567890m=ÜQWERTZUIOPÛÝASDFGHJKL;ÞYXCVBNM¼¾¿"
       ,'QWERTZ Bosnian'      : "À1234567890¿=ÜQWERTZUIOPÛÝASDFGHJKL;ÞYXCVBNM¼¾m"
       ,'QWERTZ Czech'        : "À1234567890=¿ÜQWERTZUIOPÛÝASDFGHJKL;ÞYXCVBNM¼¾m"
       ,'QWERTZ German'       : "Ü1234567890ÛÝ¿QWERTZUIOP;=ASDFGHJKLÀÞYXCVBNM¼¾m"
       ,'QWERTZ Hungarian'    : "0123456789À¿=ÜQWERTZUIOPÛÝASDFGHJKL;ÞYXCVBNM¼¾m"
       ,'QWERTZ Slovak'       : "À1234567890¿ßÜQWERTZUIOPÛÝASDFGHJKL;ÞYXCVBNM¼¾m"
       ,'QWERTZ Swiss'        : "Ü1234567890ÛÝßQWERTZUIOP;ÞASDFGHJKLÀ¿YXCVBNM¼¾m"
       ,'AZERTY Belgian'      : "Þ1234567890ÛmÜAZERTYUIOPÝ;QSDFGHJKLMÀWXCVBN¼¾¿="
       ,'AZERTY French'       : "Þ1234567890Û=ÜAZERTYUIOPÝ;QSDFGHJKLMÀWXCVBN¼¾¿ß"
       ,',WERTY Bulgarian'    : "À1234567890m¾Ü¼WERTYUIOPÛÝASDFGHJKL;ÞZXCVBNMßQ¿"
       ,'QGJRMV Latvian'      : "À1234567890mFÜQGJRMVNZWXYH;USILDATECÞÛBÝKPOß¼¾¿"
       ,'/,.PYF UK-Dvorak'    : "m1234567890ÛÝÜÀ¼¾PYFGCRL¿=AOEUIDHTNSÞ;QJKXBMWVZ"
       ,'FG;IOD Turkish F'    : "À1234567890=mXFG;IODRNHPQWUÛEAÝTKMLYÞJÜVC¿ZSB¾¼"
       ,';QBYUR US-Dvorak'    : "7ÛÝ¿PFMLJ4321Ü;QBYURSO¾65=mKCDTHEAZ8ÞÀXGVWNI¼09"
       ,'56Q.OR US-Dvorak'    : "m1234JLMFP¿ÛÝÜ56Q¾ORSUYB;=78ZAEHTDCKÞ90X¼INWVGÀ"
  }
  /**
   *  Keyboard mode, bitmap
   *
   *
   *
   *
   *  @type Number
   *  @scope private
   */
  var mode = 0
     ,VK_NORMAL = 0
     ,VK_SHIFT = 1
     ,VK_ALT = 2
     ,VK_CTRL = 4
     ,VK_CAPS = 8
     ,VK_CTRL_CAPS = VK_CTRL|VK_CAPS
     ,VK_CTRL_SHIFT = VK_CTRL|VK_SHIFT
     ,VK_ALT_CAPS = VK_ALT|VK_CAPS
     ,VK_ALT_CTRL = VK_ALT|VK_CTRL
     ,VK_ALT_CTRL_CAPS = VK_ALT|VK_CTRL|VK_CAPS
     ,VK_ALT_SHIFT = VK_ALT|VK_SHIFT
     ,VK_SHIFT_ALT_CTRL = VK_SHIFT|VK_ALT|VK_CTRL
     ,VK_SHIFT_CAPS = VK_SHIFT|VK_CAPS
     ,VK_ALL = VK_SHIFT|VK_ALT|VK_CTRL|VK_CAPS;
  /**
   *  CSS classes will be used to style buttons
   *
   *  @type Object
   *  @scope private
   */
  var cssClasses = {
    'buttonUp'        : 'kbButton'
   ,'buttonDown'      : 'kbButtonDown'
   ,'buttonHover'     : 'kbButtonHover'
   ,'hoverShift'      : 'hoverShift'
   ,'hoverAlt'        : 'hoverAlt'
   ,'modeAlt'         : 'modeAlt'
   ,'modeAltCaps'     : 'modeAltCaps'
   ,'modeCaps'        : 'modeCaps'
   ,'modeNormal'      : 'modeNormal'
   ,'modeShift'       : 'modeShift'
   ,'modeShiftAlt'    : 'modeShiftAlt'
   ,'modeShiftAltCaps': 'modeShiftAltCaps'
   ,'modeShiftCaps'   : 'modeShiftCaps'
   ,'charNormal'      : 'charNormal'
   ,'charShift'       : 'charShift'
   ,'charAlt'         : 'charAlt'
   ,'charShiftAlt'    : 'charShiftAlt'
   ,'charCaps'        : 'charCaps'
   ,'charShiftCaps'   : 'charShiftCaps'
   ,'hiddenAlt'       : 'hiddenAlt'
   ,'hiddenCaps'      : 'hiddenCaps'
   ,'hiddenShift'     : 'hiddenShift'
   ,'hiddenShiftCaps' : 'hiddenShiftCaps'
   ,'deadkey'         : 'deadKey'
   ,'noanim'          : 'VK_no_animate'

  }
  /**
   *  current layout
   *
   *  @type Object
   *  @scope public
   */
  var lang = null;
  /**
   *  Available layouts
   *
   *  Structure:
   *   [ <char1>, <charN>]
   *  with the additional properties:
   *   .name : {String} layout name to find it using switchLayout
   *   .dk   : {String} list of the active dead keys, matches and replacements
   *   .cbk  : {Function} custom input transformations
   *               OR
   *           {Object} { 'activate' : optional activation (on layout select) callback
   *                      'charProcessor' : required input transformation callback
   *                    }
   *   .rtl  : right-to-left or left-to-right input flag
   *
   *  Where <char> is the array of the chars ['<normal>','<shift>','<alt>','<shift_alt>','<caps>','<shift_caps>']
   *
   *  @type Array
   *  @scope private
   */
  var layout = []
  /**
   *  Name-to-ID map
   *
   *  @type Object
   *  @scope private
   */
  layout.hash = {};
  /**
   *  Available layout codes
   *
   *  @type Array
   *  @scope private
   */
  layout.codes = {};
  /**
   *  Filter on the layout codes
   *
   *  @type Array
   *  @scope private
   */
  layout.codeFilter = null;
  /**
   *  Generated layout options
   *
   *  @type Array
   *  @scope private
   */
  layout.options = null;

  /**
   *  Shortcuts to the nodes
   *
   *  @type Object
   *  @scope private
   */
  var nodes = {
      keyboard : null     // Keyboard container @type HTMLDivElement
     ,desk : null         // Keyboard desk @type HTMLDivElement
     ,langbox : null      // Language selector @type HTMLSelectElement
     ,attachedInput : null// Field, keyboard attached to
  }
  /**
   *  Key code to be inserted on the keypress
   *
   *  @type Number
   *  @scope private
   */
  var newKeyCode = null;

  /**************************************************************************
  **  KEYBOARD LAYOUT
  **************************************************************************/
  /**
   *  Adds a number of layouts, passed as arguments to this function
   */
  self.addLayoutList = function () {
      for (var i=0, aL=arguments.length; i<aL; i++) {
          self.addLayout(arguments[i]);
      }
  }
  /**
   *  Add layout to the list
   *
   *  @see #layout
   *  @param {Object} l layout description hash:
   *    { 'code'       : {String} layout code in form {language-COUNTRY}
   *     ,'name'       : {String} layout name
   *     ,'normal'     : {String,Array} keycodes without any modifiers, empty key should be set to 0x02 in array or char from this code in string
   *     ,'shift'      : {Object} optional shift keys, in form of <offset> : <codes>
   *     ,'alt'        : {Object} optional altgr keys, in form of <offset> : <codes>
   *     ,'shift_alt'  : {Object} optional shift+altgr keys, in form of <offset> : <codes>
   *     ,'caps'       : {Object} optional caps keys, in form of <offset> : <codes>
   *     ,'shift_caps' : {Object} optional shift+caps keys, in form of <offset> : <codes>
   *     ,'dk'   : {String} list of the active deadkeys in form of <char> : <deadkeys>
   *     ,'cbk' : {Function} char processing callback
   *                OR
   *              { 'activate' : {Function} optional activation callback (called from switchLayout)
   *               ,'charProcessor' : {Function} required char processing callback
   *              }
   *    }
   *
   *  <codes> is the array or string of the symbols. Codes might contain a ligatures in the form:
   *   string: substring of '0x01<char1><charN>0x01'
   *   array:  array of [<charCode1>,<charCodeN>]
   *
   *  <deadkeys> is the string or array of the matches and replacements
   *   string: string of '<match1><replacement1><matchN><replacementN>
   *   array: array of [<matchCharCode1><replacementCharCode1><matchCharCodeN><replacementCharCodeN>]
   *
   *
   *  @scope public
   */
  self.addLayout = function(l) {

      var code = l.code.entityDecode().split("-")
         ,name = l.name.entityDecode()
         ,alpha = __doParse(l.normal)

      if (!isArray(alpha) || 47!=alpha.length) throw new Error ('VirtualKeyboard requires \'keys\' property to be an array with 47 items, '+alpha.length+' detected. Layout code: '+code+', layout name: '+name);

      /*
      *  overwrite keys with parsed data for future use
      */
      l.code = (code[1] || code[0]);
      l.name = name;
      l.normal = alpha;
      l.domain = code[0];

      /*
      *  don't touch already existing layout
      */
      if (layout.hash.hasOwnProperty(l.code+" "+l.name))
          return;

      /*
      *  update list of the layout codes
      */
      if (!layout.codes.hasOwnProperty(l.code))
          layout.codes[l.code] = l.code;

      /*
      *  nice print of the layout
      */
      l.toString = function(){return this.code+" "+this.name};

      layout.push(l);

      /*
      *  reset hash, to be recalculated on options draw
      */
      layout.options = null;
  }
  /**
   *  Set current layout
   *
   *  @param {String} code layout name
   *  @return {Boolean} change state
   *  @scope public
   */
  self.switchLayout = function (code) {
    /*
    *  trying to regenerate options list
    */
    __buildOptionsList();

    if (!layout.options.hasOwnProperty(code)) return false;

    /*
    *  hide IME on layout switch
    */
    self.IME.hide();

    /*
    *  touch the dropdown box
    */
    nodes.langbox.options[layout.options[code]].selected = true;

    lang = layout[layout.hash[code]];
    if (!isArray(lang)) lang = layout[layout.hash[code]] = __prepareLayout(lang);

    if (!isArray(lang)) {
        lang = layout[layout.hash[code]] = __prepareLayout(lang);
    }
    if (!lang.html) {
        lang.html = __getKeyboardHtml(lang);
    }
    /*
    *  overwrite layout
    */
    nodes.desk.innerHTML = lang.html;

    /*
    *  set layout-dependent class names
    */
    nodes.keyboard.className = lang.domain
    self.IME.css = lang.domain

    /*
    *  reset mode for the new layout
    */
    mode = VK_NORMAL;
    __updateLayout();
    /*
    *  call IME activation method, if exists
    */
    if (isFunction(lang.activate)) {
        lang.activate();
    }
    /*
    *  toggle RTL/LTR state
    */
    __toggleInputDir();
    /*
    *  save layout name
    */
    DocumentCookie.set('vk_layout', code)
    return true;
  }

  /**
   *  Return the list of the available layouts
   *
   *  @return {Array}
   *  @scope public
   */
  self.getLayouts = function () {
      var lts = [];
      for (var i=0,lL=layout.length;i<lL;i++) {
          lts[lts.length] = [layout[i].code,layout[i].name];
      }
      return lts.sort();
  }
  /**
   *  Sets the layouts groups, available for operations
   *  Accepts a serie of strings, supposed to be layout group names
   *
   *  @scope public
   */
  self.setVisibleLayoutCodes = function () {
      var codes = isArray(arguments[0])?arguments[0]:arguments
         ,filter = null
         ,code

      for (var i=0, cL=codes.length; i<cL; i++) {
          code = codes[i].toUpperCase();
          if (!layout.codes.hasOwnProperty(code))
              continue;
          if (!filter)
              filter = {}
          filter[code] = code;
      }
      layout.codeFilter = filter;

      /*
      *  reset hash, to be recalculated on options draw
      */
      layout.options = null;

      if (!self.switchLayout(nodes.langbox.value)) {
          /*
          *  if first try fails, make a second try... on the regenerated list
          */
          self.switchLayout(nodes.langbox.value);
      }
  }
  /**
   *  Returns available layout codes
   *
   *  @return {Array} codes
   */
  self.getLayoutCodes = function () {
      var codes = [];
      for (var i in layout.codes) {
          if (!layout.codes.hasOwnProperty(i))
              continue;
          codes.push(i);
      }
      return codes.heapSort();
  }
  //---------------------------------------------------------------------------
  // GLOBAL EVENT HANDLERS
  //---------------------------------------------------------------------------
  /**
   *  Do the key clicks, caught from both virtual and real keyboards
   *
   *  @param {HTMLInputElement} key on the virtual keyboard
   *  @param {EventTarget} evt optional event object, to be used to re-map the keyCode
   *  @scope private
   */
  var _keyClicker_ = function (key, evt) {
      var chr = ""
         ,ret = false;
      key = key.replace(idPrefix, "");
      switch (key) {
          case KEY.CAPS  :
          case KEY.SHIFT :
          case "shift_left" :
          case "shift_right" :
          case KEY.ALT   :
          case "alt_left" :
          case "alt_right" :
              return true;
          case 'backspace':
              /*
              *  if layout has char processor and there's any selection, ask it for advice
              */
              if (isFunction(lang.charProcessor) && DocumentSelection.getSelection(nodes.attachedInput).length) {
                  chr = "\x08";
              } else if (evt) {
                  self.IME.hide(true);
                  return true;
              } else {
                  DocumentSelection.deleteAtCursor(nodes.attachedInput, false);
                  self.IME.hide(true);
              }
              break;
          case 'del':
              self.IME.hide(true);
              if (evt)
                  return true;
              DocumentSelection.deleteAtCursor(nodes.attachedInput, true);
              break;
          case 'space':
              chr = " ";
              break;
          case 'tab':
              chr = "\t";
              break;
          case 'enter':
              chr = "\n";
              break;
          default:
              var el = document.getElementById(idPrefix+key);
              chr = lang[key][mode];
              break;
      }
      if (chr) {
          /*
          *  process current selection and new symbol with __charProcessor, it might update them
          */
          if (!(chr = __charProcessor(chr, DocumentSelection.getSelection(nodes.attachedInput)))) return ret;
          /*
          *  try to create an event, then fallback to DocumentSelection, if something fails
          */
          try {
              /*
              *  throw an error when selection is required or multiple chars submitted
              *  it's simpler than write number of nesting if..else statements
              */
              if (chr[1] || chr[0].length>1 || chr.charCodeAt(0)>0x7fff || nodes.attachedInput.contentDocument || '\t' == chr[0]) {
                  throw new Error;
              }
              var ck = chr[0].charCodeAt(0);
              /*
              *  trying to create an event, borrowed from YAHOO.util.UserAction
              */
              if (isFunction(document.createEvent)) {
                  var evt = null;
                  try {
                      evt = document.createEvent("KeyEvents");
                      evt.initKeyEvent('keypress', false, true, nodes.attachedInput.contentWindow, false, false, false, false, 0, ck);
                  } catch (ex) {
                      /*
                      *  Safari implements
                      */
                      evt = document.createEvent("KeyboardEvents");
                      evt.initKeyEvent('keypress', false, true, nodes.attachedInput.contentWindow, false, false, false, false, ck, 0);
                  }
                  evt.VK_bypass = true;
                  nodes.attachedInput.dispatchEvent(evt);
              } else {
                  evt.keyCode = 10==ck?13:ck;
                  ret = true;
              }
          } catch (e) {
              DocumentSelection.insertAtCursor(nodes.attachedInput,chr[0]);
              /*
              *  select as much, as __charProcessor callback requested
              */
              if (chr[1]) {
                  DocumentSelection.setRange(nodes.attachedInput,-chr[1],0,true);
              }
          }
      }
      return ret;
  }
  /**
   *  Captures some keyboard events
   *
   *  @param {Event} keydown
   *  @scope protected
   */
  var _keydownHandler_ = function(e) {
    /*
    *  it's global event handler. do not process event, if keyboard is closed
    */
    if (!self.isOpen()) return;
    /*
    *  record new keyboard mode
    */
    var newMode = mode;
    /*
    *  differently process different events
    */
    var keyCode = e.getKeyCode();
    switch (e.type) {
      case 'keydown' :
        switch (keyCode) {
          case 37:
              if (self.IME.isOpen()) {
                  self.IME.prevPage(e);
                  return;
              }
              break;
          case 39:
              if (self.IME.isOpen()) {
                  self.IME.nextPage(e);
                  return;
              }
              break;
          case 8: // backspace
          case 9: // tab
          case 46: // del
              var el = nodes.desk.childNodes[keymap[keyCode]];
              /*
              *  set the class only 1 time
              */
              if (animate && !e.getRepeat()) DOM.CSS(el).addClass(cssClasses.buttonDown);
              if (!_keyClicker_(el.id, e)) e.preventDefault();

              break;
          case 20: //caps lock
              if (!e.getRepeat()) {
                  newMode = newMode ^ VK_CAPS;
              }
              break;
          case 27:
              if (self.IME.isOpen()) {
                  self.IME.hide();
              } else {
                  var start = DocumentSelection.getStart(nodes.attachedInput);
                  DocumentSelection.setRange(nodes.attachedInput, start, start);
              }
              return false;
          default:
              if (!e.getRepeat()) {
                  newMode = newMode|e.shiftKey|e.ctrlKey<<2|e.altKey<<1;
              }
              if (keymap.hasOwnProperty(keyCode)) {
                  if (!(e.altKey ^ e.ctrlKey)) {
                      var el = nodes.desk.childNodes[keymap[keyCode]];
                      if (animate) DOM.CSS(el).addClass(cssClasses.buttonDown);
                      /*
                      *  assign the key code to be inserted on the keypress
                      */
                      newKeyCode = el.id;
                  }
                  if (e.altKey && e.ctrlKey) {
                      e.preventDefault();
                      /*
                      *  this block is used to print a char when ctrl+alt pressed
                      *  browsers does not invoke "kepress" in this case
                      */
                      if (e.srcElement) {
                          _keyClicker_(nodes.desk.childNodes[keymap[keyCode]].id, e)
                          newKeyCode = "";
                      }
                  }
              } else {
                  self.IME.hide();
              }
              break;
        }
        break;
      case 'keyup' :
        switch (keyCode) {
            case 20:
                break;
            default:
                if (!e.getRepeat()) {
                    newMode = mode&(VK_ALL^(!e.shiftKey|(!e.ctrlKey<<2)|(!e.altKey<<1)));
                }
                if (animate && keymap.hasOwnProperty(keyCode)) {
                    DOM.CSS(nodes.desk.childNodes[keymap[keyCode]]).removeClass(cssClasses.buttonDown);
                }
        }
        break;
      case 'keypress' :
        /*
        *  flag is set only when virtual key passed to input target
        */
        if (newKeyCode && !e.VK_bypass) {
            if (!_keyClicker_(newKeyCode, e)) {
                e.stopPropagation();
                /*
                *  keeps browsers away from running built-in event handlers
                */
                e.preventDefault();
            }
            /*
            *  reset flag
            */
            newKeyCode = null;
        }
        if (!mode^VK_ALT_CTRL && (e.altKey || e.ctrlKey)) {
            self.IME.hide();
        }
        if (0==keyCode && !newKeyCode && !e.VK_bypass  // suppress dead keys from the keyboard driver
          && (!e.ctrlKey && !e.altKey && !e.shiftKey)  // only when no special keys pressed, unblocking system shortcuts
           ) {
            e.preventDefault();
        }
    }
    /*
    *  update layout state
    */
    if (newMode != mode) {
        __updateControlKeys(newMode);
        __updateLayout();
    }
  }
  /**
   *  Handle clicks on the buttons, actually used with mouseup event
   *
   *  @param {Event} mouseup event
   *  @scope protected
   */
  var _btnClick_ = function (e) {
    /*
    *  either a pressed key or something new
    */
    var el = DOM.getParent(e.srcElement||e.target,'a');
    /*
    *  skip invalid nodes
    */
    if (!el || el.parentNode.id.indexOf(idPrefix)<0) return;
    el = el.parentNode;

    switch (el.id.substring(idPrefix.length)) {
      case "caps":
      case "shift_left":
      case "shift_right":
      case "alt_left":
      case "alt_right":
      case "ctrl_left":
      case "ctrl_right":
          return;
    }

    if (DOM.CSS(el).hasClass(cssClasses.buttonDown) || !animate) {
        _keyClicker_(el.id);
    }
    if (animate) {
        DOM.CSS(el).removeClass(cssClasses.buttonDown)
    }

    var newMode = mode&(VK_CAPS|e.shiftKey|e.altKey<<1|e.ctrlKey<<2);
    if (mode != newMode) {
        __updateControlKeys(newMode);
        __updateLayout();
    }

  }
  /**
   *  Handle mousedown event
   *
   *  Method is used to set 'pressed' button state and toggle shift, if needed
   *  Additionally, it is used by keyboard wrapper to forward keyboard events to the virtual keyboard
   *
   *  @param {Event} mousedown event
   *  @scope protected
   */
  var _btnMousedown_ = function (e) {
    /*
    *  either pressed key or something new
    */
    var el = DOM.getParent(e.srcElement||e.target, 'a');
    /*
    *  skip invalid nodes
    */
    if (!el || el.parentNode.id.indexOf(idPrefix)<0) return;
    el = el.parentNode;

    var newMode = mode;

    var key = el.id.substring(idPrefix.length);
    switch (key) {
      case "caps":
        newMode = newMode ^ VK_CAPS;
        break;
      case "shift_left":
      case "shift_right":
        /*
        *  Shift is pressed in on both keyboard and virtual keyboard, return
        */
        if (e.shiftKey) break;
        newMode = newMode ^ VK_SHIFT;
        break;
      case "alt_left":
      case "alt_right":
      case "ctrl_left":
      case "ctrl_right":
          newMode = newMode ^ (e.altKey<<1^VK_ALT) ^ (e.ctrlKey<<2^VK_CTRL);
          break;
      /*
      *  any real pressed key
      */
      default:
        if (animate) DOM.CSS(el).addClass(cssClasses.buttonDown)
        break;
    }

    if (mode != newMode) {
        __updateControlKeys(newMode);
        __updateLayout();
    }

    e.preventDefault();
    e.stopPropagation();
  }
  /**
   *  Handle mouseout and mouseover events
   *
   *  Method is used to remove 'pressed' button state
   *
   *  @param {Event} mouseup event
   *  @scope protected
   */
  var _btnMouseInOut_ = function (e) {
    /*
    *  either pressed key or something new
    */
    var el = DOM.getParent(e.srcElement||e.target, 'a')
       ,mtd = {'mouseover': 2, 'mouseout' : 3}
    /*
    *  skip invalid nodes
    */
    if (!el || el.parentNode.id.indexOf(idPrefix)<0) return;
    el = el.parentNode;

    /*
    *  hard-to-avoid IE bug cleaner. if 'hover' state is get removed, button looses it's 'down' state
    *  should be applied for every button, needed to save 'pressed' state on mouseover/out
    */
    if (el.id.indexOf('shift')>-1) {
        /*
        *  both shift keys should be blurred
        */
        __toggleControlKeysState(mtd[e.type], KEY.SHIFT);
    } else if (el.id.indexOf('alt')>-1 || el.id.indexOf('ctrl')>-1) {
        /*
        *  both alt and ctrl keys should be blurred
        */
        __toggleControlKeysState(mtd[e.type], KEY.CTRL);
        __toggleControlKeysState(mtd[e.type], KEY.ALT);
    } else if (el.id.indexOf('caps')>-1) {
        __toggleKeyState(mtd[e.type], null, el.id);
    } else if (animate) {
        __toggleKeyState(mtd[e.type], null, el.id);
        if ('mouseout' == e.type.toLowerCase()) {
            /*
            *  reset 'hover' state
            */
            __toggleKeyState(0, null, el.id);
        }
    }
    e.preventDefault();
    e.stopPropagation();
  }

  /**
   *  Switches keyboard map...
   *
   *  @param {Event} e
   *  @scope private
   */
  var switchMapping = function (e) {
      DocumentCookie.set('vk_mapping', e.target.value);
      keymap = keymaps[e.target.value];
  }
  /**********************************************************
  *  MOST COMMON METHODS
  **********************************************************/
  /**
   *  Used to attach keyboard output to specified input
   *
   *  @param {Null, HTMLInputElement,String} element to attach keyboard to
   *  @return {HTMLInputElement, Null}
   *  @scope public
   */
  self.attachInput = function (el) {
    /*
    *  if null is supplied, don't change the target field
    */
    if (!el) return nodes.attachedInput;
    if (isString(el)) el = document.getElementById(el);

    if (el == nodes.attachedInput) return nodes.attachedInput;

    /*
    *  perform initialization...
    */
    if (!self.switchLayout(options.layout) && !self.switchLayout(nodes.langbox.value)) {
         /*
         *  if both tries fail, go away
         */
         throw new Error ('No layouts available');
    }

    /*
    *  detach everything
    */
    self.detachInput();

    if (!el || !el.tagName) {
        nodes.attachedInput = null;
    } else {

        /*
        *  set keyboard animation for the current field
        */
        animate = !DOM.CSS(el).hasClass(cssClasses.noanim);
        /*
        *  for iframe target we track its HTML node
        */
        nodes.attachedInput = el;
        /*
        *  set input direction
        */
        __toggleInputDir();
        if (el.contentWindow) {
            el = el.contentWindow.document.body.parentNode;
        }
        EM.addEventListener(el,'keydown',_keydownHandler_);
        EM.addEventListener(el,'keyup',_keydownHandler_);
        EM.addEventListener(el,'keypress',_keydownHandler_);
        EM.addEventListener(el,'mousedown',self.IME.blurHandler);
    }
    return nodes.attachedInput;
  }

  /**
   *  Detaches input from the virtual keyboard
   *
   *  @return detach state
   *  @scope private
   */
  self.detachInput = function () {
      if (!nodes.attachedInput) return false;
      /*
      *  reset input state, defined earlier
      */
      __toggleInputDir(true);
      /*
      *  force IME hide on field switch
      */
      self.IME.hide();
      /*
      *  remove every VK artifact from the old input
      */
      if (nodes.attachedInput) {
          var oe = nodes.attachedInput
          if (oe.contentWindow) {
              oe = oe.contentWindow.document.body.parentNode
          }
          EM.removeEventListener(oe,'keydown',_keydownHandler_);
          EM.removeEventListener(oe,'keypress',_keydownHandler_);
          EM.removeEventListener(oe,'keyup',_keydownHandler_);
          EM.removeEventListener(oe,'mousedown',self.IME.blurHandler);
      }
      nodes.attachedInput = null;
      return true;
  }

  /**
   *  Returns the attached input node
   *
   *  @return {HTMLInputElement, Null}
   *  @scope public
   */
  self.getAttachedInput = function (el) {
      return nodes.attachedInput;
  }
  /**
   *  Shows keyboard
   *
   *  @param {HTMLElement, String} input element or it to bind keyboard to
   *  @param {String} holder keyboard holder container, keyboard won't have drag-drop when holder is specified
   *  @param {HTMLElement} kpTarget optional target to bind key* event handlers to,
   *                       is useful for frame and popup keyboard placement
   *  @return {Boolean} operation state
   *  @scope public
   */
  self.open =
  self.show = function (input, holder, kpTarget){
    if ( !(input = self.attachInput(nodes.attachedInput || input)) || !nodes.keyboard || !document.body ) return false;

    /*
    *  check pass means that node is not attached to the body
    */
    if (!nodes.keyboard.parentNode || nodes.keyboard.parentNode.nodeType==11) {
        if (isString(holder)) holder = document.getElementById(holder);
        if (!holder.appendChild) return false;
        holder.appendChild(nodes.keyboard);
        /*
        *  we'll bind event handler here
        */
        if (!isUndefined(kpTarget) && input != kpTarget && kpTarget.appendChild) {
            EM.addEventListener(kpTarget,'keydown', _keydownHandler_);
            EM.addEventListener(kpTarget,'keyup', _keydownHandler_);
            EM.addEventListener(kpTarget,'keypress', _keydownHandler_);
        }
    }

    return true;
  }
  /**
   *  Hides the keyboard
   *
   *  @return {Boolean}
   *  @scope public
   */
  self.close =
  self.hide = function () {
    if (!nodes.keyboard || !self.isOpen()) return false;
    self.detachInput();
    nodes.keyboard.parentNode.removeChild(nodes.keyboard);
    return true;
  }
  /**
   *  Toggles keyboard state
   *
   *  @param {HTMLElement, String} input element or it to bind keyboard to
   *  @param {String} holder keyboard holder container, keyboard won't have drag-drop when holder is specified
   *  @param {HTMLElement} kpTarget optional target to bind key* event handlers to,
   *                       is useful for frame and popup keyboard placement
   *  @return {Boolean} operation state
   *  @scope public
   */
  self.toggle = function (input, holder, kpTarget) {
      self.isOpen()?self.close():self.show(input, holder, kpTarget);
  }
  /**
   *  Returns true if keyboard is opened
   *
   *  @return {Boolean}
   *  @scope public
   */
  self.isOpen = function () /* :Boolean */ {
      return (!!nodes.keyboard.parentNode) && nodes.keyboard.parentNode.nodeType == 1;
  }
  //---------------------------------------------------------------------------
  // PRIVATE METHODS
  //---------------------------------------------------------------------------
  /**
   *  Sets input direction mode
   *
   *  @param {Boolean} reset resets input mode to default, when true
   */
  var __toggleInputDir = function (reset) {
      if (nodes.attachedInput) {
          var mode = reset?""
                          :(lang.rtl?'rtl'
                                    :'ltr');
          if (nodes.attachedInput.contentWindow)
              nodes.attachedInput.contentWindow.document.body.dir = mode;
          else
              nodes.attachedInput.dir = mode;
      }
  }

  /**
   *  Builds options for the layout selection box
   *
   *  @scope private
   */
  var __buildOptionsList = function () {
      if (null != layout.options)
          return;

      var s = layout.heapSort()
         ,l,o,n
         ,cc = {};
      layout.options = {};

      nodes.langbox.innerHTML = "";
      for (var i=0,sL=s.length,z=0;i<sL;i++) {
          l = layout[i];
          n = l.code+" "+l.name;
          layout.hash[n] = i;

          if (layout.codeFilter && !layout.codeFilter.hasOwnProperty(l.code))
              continue;

          if (cc.label!=l.code) {
              cc = document.createElement('optgroup');
              cc.label = l.code;
              nodes.langbox.appendChild(cc);
          }
          o = document.createElement('option');
          o.value = n;
          o.appendChild(document.createTextNode(l.name));
          o.label = l.name;
          cc.appendChild(o);
          /*
          *  record option position
          */
          layout.options[n] = z++;
      }
  }
  /**
   *  Converts string of chars or array of char codes to the array of chars
   *
   *  @param {Array, String} s source to check&parse
   *  @return {Array}
   *  @scope private
   */
  var __doParse = function(s) {
      if (isString(s))
          return s.match(/\x01.+?\x01|[\ud800-\udbff][\udc00-\udfff]|./g).map(function(a){return a.replace(/[\x01\x02]/g,"")});
      else
          return s.map(function(a){return isArray(a)?a.map(function(s){String.fromCharCodeExt(s)}).join(""):String.fromCharCodeExt(a).replace(/[\x01\x02]/g,"")});
  }
  /**
   *  Prepares layout for typing
   *
   *  @param {Object} l layout object to process
   *  @scope private
   */
  var __prepareLayout = function(l) {
      /*
      *  convert layout in machine-aware form
      */
      var alpha      = l.normal
         ,shift      = l.shift        || {}
         ,alt        = l.alt          || {}
         ,shift_alt  = l.shift_alt    || {}
         ,caps       = l.caps         || {}
         ,shift_caps = l.shift_caps   || {}
         ,dk         = l.dk
         ,cbk        = l.cbk
         ,cs,  ca,  csa,  cc,  csc = null
         ,ics, ica, icsa, icc, icsc = -1
         ,lt         = []

      lt.name = l.name;
      lt.code = l.code;
      lt.toString = l.toString;

      for (var i=0, aL = alpha.length; i<aL; i++) {
         var char_normal = alpha[i]
            ,char_alt    = null
            ,char_caps   = null
            ,char_shift  = null
            ,char        = [char_normal] // normal chars

         if (shift.hasOwnProperty(i)) {
             cs = __doParse(shift[i]);
             ics = i;
         }
         if (ics>-1 && cs[i-ics]) {
             char_shift = cs[i-ics];
             char[VK_SHIFT] = char_shift;
         } else if (char_normal && char_normal != (char_normal = char_normal.toUpperCase())) {
             char[VK_SHIFT] = char_normal;
             char_shift = char_normal;
         }

         if (alt.hasOwnProperty(i)) {
             ca = __doParse(alt[i]);
             ica = i;
         }
         if (ica>-1 && ca[i-ica]) {
             char_alt = ca[i-ica];
             char[VK_ALT_CTRL] = char_alt;
         }

         if (shift_alt.hasOwnProperty(i)) {
             csa = __doParse(shift_alt[i]);
             icsa = i;
         }
         if (icsa>-1 && csa[i-icsa]) {
             char[VK_SHIFT_ALT_CTRL] = csa[i-icsa];
         } else if (char_alt && char_alt != (char_alt = char_alt.toUpperCase())) {
             char[VK_SHIFT_ALT_CTRL] = char_alt;
         }

         if (caps.hasOwnProperty(i)) {
             cc = __doParse(caps[i]);
             icc = i;
         }
         if (icc>-1 && cc[i-icc]) {
             char_caps = cc[i-icc];
         }
         if (char_caps) {
             char[VK_CAPS] = char_caps;
         } else if (char_shift && char_shift.toUpperCase() != char_shift.toLowerCase()) {
             char[VK_CAPS] = char_shift;
         } else if (char_normal) {
             char[VK_CAPS] = char_normal.toUpperCase();
         }

         if (shift_caps.hasOwnProperty(i)) {
             csc = __doParse(shift_caps[i]);
             icsc = i;
         }
         if (icsc>-1 && csc[i-icsc]) {
             char[VK_SHIFT_CAPS] = csc[i-icsc];
         } else if (char_shift) {
             char[VK_SHIFT_CAPS] = char_shift.toLowerCase();
         } else if (char_normal) {
             char[VK_SHIFT_CAPS] = char_normal;
         }

         lt[i] = char;
      }

      if (dk) {
          lt.dk = {};
          for (var i in dk) {
              if (dk.hasOwnProperty(i)) {
                  var key = i;
                  if (parseInt(i) && i>9) {
                      key = String.fromCharCode(i);
                  }
                  /*
                  * last replace is used to simplify char processor
                  * deadkey found in the deadkey list will be substituted with itself on +1 position
                  */
                  lt.dk[key] = __doParse(dk[i]).join("").replace(key,key+key);
              }
          }
      }

      /*
      *  check for right-to-left languages
      */
      lt.rtl = !!lt.join("").match(/[\u05b0-\u06ff]/)

      /*
      *  this CSS will be set on kbDesk
      */
      lt.domain = l.domain

      /*
      *  finalize things by calling loading callback, if exists
      */
      if (isFunction(cbk)) {
          lt.charProcessor = cbk
      } else if (cbk) {
          lt.activate = cbk.activate;
          lt.charProcessor = cbk.charProcessor;
      }
      return lt;
  }
  /**
   *  Toggles layout mode (switch alternative key bindings)
   *
   *  @scope private
   */
  var __updateLayout = function () {
    var ca = [];
    ca[VK_NORMAL]         = cssClasses.modeNormal;
    ca[VK_SHIFT]          = cssClasses.modeShift;
    ca[VK_ALT_CTRL]       = cssClasses.modeAlt;
    ca[VK_SHIFT_ALT_CTRL] = cssClasses.modeShiftAlt;
    ca[VK_CAPS]           = cssClasses.modeCaps;
    ca[VK_SHIFT_CAPS]     = cssClasses.modeShiftCaps;
    // these ones are the subject to change
    ca[VK_ALT]            = cssClasses.modeNormal;
    ca[VK_CTRL]           = cssClasses.modeNormal;
    ca[VK_ALT_SHIFT]      = cssClasses.modeShift;
    ca[VK_CTRL_SHIFT]     = cssClasses.modeShift;
    ca[VK_ALT_CAPS]       = cssClasses.modeCaps;
    ca[VK_CTRL_CAPS]      = cssClasses.modeCaps;
    // below ones are not used and should
    ca[VK_ALT_CTRL_CAPS]  = cssClasses.modeShiftAltCaps;
    ca[VK_ALL]            = cssClasses.modeShiftAltCaps;

    DOM.CSS(nodes.desk).removeClass(ca).addClass(ca[mode]);
  }
  /**
   *  Sets specified state on dual keys (like Alt, Ctrl)
   *
   *  @param {String} a1 key suffix to be checked
   *  @param {Number} a2 keyboard mode
   *  @scope private
   */
  var __updateControlKeys = function (newMode) {
      /*
      *  all changed bits will be raised
      */
      var changes = mode ^ newMode;
      if (changes&VK_SHIFT) {
          __toggleControlKeysState(!!(newMode&VK_SHIFT), KEY.SHIFT);
      }
      if (changes&VK_ALT) {
          __toggleControlKeysState(!!(newMode&VK_ALT), KEY.ALT);
      }
      if (changes&VK_CTRL) {
          __toggleControlKeysState(!!(newMode&VK_CTRL), KEY.CTRL);
      }
      if (changes&VK_CAPS) {
          __toggleKeyState(!!(newMode&VK_CAPS), KEY.CAPS);
      }
      mode = newMode;
  }
  /**
   *  Toggles control key state, designed for dual keys only
   *
   *  @param {Number, Boolean} state one of raised (0), down (1), hover (2)
   *  @param {String} prefix key name to be evaluated
   */
  var __toggleControlKeysState = function (state, prefix) {
      var s1 = document.getElementById(idPrefix+prefix+'_left')
         ,s2 = document.getElementById(idPrefix+prefix+'_right');
      switch (0+state) {
          case 0:
              s1.className = DOM.CSS(s2).removeClass(cssClasses.buttonDown).getClass();
              break;
          case 1:
              DOM.CSS(nodes.desk).removeClass([cssClasses.hoverShift, cssClasses.hoverAlt]);
              s1.className = DOM.CSS(s2).addClass(cssClasses.buttonDown).getClass();
              break;
          case 2:
              if (KEY.SHIFT==prefix && mode&VK_SHIFT^VK_SHIFT) {
                  DOM.CSS(nodes.desk).addClass(cssClasses.hoverShift);
              } else if (KEY.ALT==prefix && mode ^ VK_ALT_CTRL) {
                  DOM.CSS(nodes.desk).addClass(cssClasses.hoverAlt);
              }
              s1.className = DOM.CSS(s2).addClass(cssClasses.buttonHover).getClass();
              break;
          case 3:
              if (KEY.SHIFT==prefix) {
                  DOM.CSS(nodes.desk).removeClass(cssClasses.hoverShift);
              } else if (KEY.ALT==prefix) {
                  DOM.CSS(nodes.desk).removeClass(cssClasses.hoverAlt);
              }
              s1.className = DOM.CSS(s2).removeClass(cssClasses.buttonHover).getClass();
              break;
      }
  }
  /**
   *  Toggles key state
   *
   *  @param {Number, Boolean} state one of raised (0), down (1), hover (2)
   *  @param {String} suffix optional key suffix
   *  @param {String} name optional key name
   */
  var __toggleKeyState = function (state, suffix, name) {
      var s = document.getElementById(suffix? idPrefix+suffix
                                            : name);
      if (s) {
          switch (0+state) {
              case 0:
                  DOM.CSS(s).removeClass(cssClasses.buttonDown);
                  break;
              case 1:
                  DOM.CSS(s).addClass(cssClasses.buttonDown);
                  break;
              case 2:
                  DOM.CSS(s).addClass(cssClasses.buttonHover);
                  break;
              case 3:
                  DOM.CSS(s).removeClass(cssClasses.buttonHover);
                  break;
          }
      }
  }
  /**
   *  Char processor
   *
   *  It does process input letter, possibly modifies it
   *
   *  @param {String} char letter to be processed
   *  @param {String} buf current keyboard buffer
   *  @return {Array} new char, flag keep buffer contents
   *  @scope private
   */
  var __charProcessor = function (tchr, buf) {
    var res = [tchr, 0];
    if (isFunction(lang.charProcessor)) {
      /*
      *  call user-supplied converter
      */
      res = lang.charProcessor(tchr,buf);
    } else if (tchr == "\x08") {
      res = ['',0];
    } else if (lang.dk && buf.length <= 1) {
      /*
      *  process char in buffer first
      *  buffer size should be exactly 1 char to don't mess with the occasional selection
      */
      if (lang.dk.hasOwnProperty(buf)) {
        /*
        *  dead key found, no more future processing
        *  if new key is not an another deadkey
        */
        res[1] = 0;
        var dks = lang.dk[buf]
            idx = dks.indexOf(tchr)+1;
        res[0] = idx?dks.charAt(idx)
                    :tchr;
      } else if (lang.dk.hasOwnProperty(tchr)) {
        /*
        *  in all other cases, process char as usual
        */
        res[1] = 1;
        res[0] = tchr;
      }
    }
    return res;
  }
  /**
   * Keyboard layout builder
   *
   * @param {Array} lang keys to put on the keyboard
   * @return {String} serialized HTML
   * @scope private
   */
  var __getKeyboardHtml = function (lang) {
      var inp = document.createElement('span');
      /*
      *  inp is used to calculate real char width and detect combining symbols
      *  @see __getCharHtmlForKey
      */
      document.body.appendChild(inp);
      inp.style.position = 'absolute';
      inp.style.left = '-1000px';

      for (var i=0, aL=lang.length, btns = [], chr, title; i<aL; i++) {
          chr = lang[i];
          btns.push(["<div id='",idPrefix,i
                    ,"' class='",cssClasses.buttonUp
                    ,"'><a>",__getCharHtmlForKey(lang, chr, VK_NORMAL,         cssClasses.charNormal,    inp)
                            ,__getCharHtmlForKey(lang, chr, VK_SHIFT,          cssClasses.charShift,     inp)
                            ,__getCharHtmlForKey(lang, chr, VK_ALT_CTRL,       cssClasses.charAlt,       inp)
                            ,__getCharHtmlForKey(lang, chr, VK_SHIFT_ALT_CTRL, cssClasses.charShiftAlt,  inp)
                            ,__getCharHtmlForKey(lang, chr, VK_CAPS,           cssClasses.charCaps,      inp)
                            ,__getCharHtmlForKey(lang, chr, VK_SHIFT_CAPS,     cssClasses.charShiftCaps, inp)
                    ,"</a></div>"].join(""));

      }
      for (var i in controlKeys) {
          if (controlKeys.hasOwnProperty(i)) {
              chr = controlKeys[i];
              title = chr.replace(/_.+/,'');
              btns.splice(i,0,["<div id='",idPrefix,chr
                              ,"' class='",cssClasses.buttonUp
                              ,"'><a title='",title,"'"
                              ,"><span class='title'>",title,"</span>"
                              ,"</a></div>"].join(""));
          }
      }
      document.body.removeChild(inp);
      return btns.join("").replace(/(<\w+)/g,"$1 unselectable='on' ");
  }
  /**
   *  Char html constructor
   *
   *  @param {Object} lyt layout object
   *  @param {String} chr char code
   *  @param {Number} mode char modifier
   *  @param {String} css optional additional class names
   *  @param {HTMLInputElement} i input field to test char length against
   *  @return {String} resulting html
   *  @scope private
   */
  var __getCharHtmlForKey = function (lyt, chr, mode, css, inp) {
      var html = []
         ,dk = lyt.dk && lyt.dk.hasOwnProperty(chr[mode])
         ,char = chr[mode] || ""

      /*
      *  if key matches agains current deadchar list
      */
      if (dk) css += " "+cssClasses.deadkey;

      /*
      *  the following css classes define hiding of the chars which should not be shown together
      */
      if ((mode == VK_SHIFT_CAPS && chr[VK_CAPS] && char.toLowerCase() == chr[VK_CAPS].toLowerCase())
       || (mode == VK_CAPS && chr[VK_SHIFT_CAPS] && char.toLowerCase() == chr[VK_SHIFT_CAPS].toLowerCase())) {
          css += " "+cssClasses.hiddenCaps;
      }
      if ((mode == VK_SHIFT && chr[VK_NORMAL] && char.toLowerCase() == chr[VK_NORMAL].toLowerCase())
       || (mode == VK_NORMAL && chr[VK_SHIFT] && char.toLowerCase() == chr[VK_SHIFT].toLowerCase())) {
          css += " "+cssClasses.hiddenShift;
      }
      if ((mode == VK_SHIFT && chr[VK_SHIFT_CAPS] && char.toLowerCase() == chr[VK_SHIFT_CAPS].toLowerCase())
       || (mode == VK_SHIFT_CAPS && chr[VK_SHIFT] && char.toLowerCase() == chr[VK_SHIFT].toLowerCase())) {
          css += " "+cssClasses.hiddenShiftCaps;
      }
      if ((mode == VK_CAPS && chr[VK_NORMAL] && char.toLowerCase() == chr[VK_NORMAL].toLowerCase())
       || (mode == VK_NORMAL && chr[VK_CAPS] && char.toLowerCase() == chr[VK_CAPS].toLowerCase())) {
          css += " "+cssClasses.hiddenCaps;
      }
      if ((mode == VK_SHIFT_ALT_CTRL && chr[VK_ALT_CTRL] && char.toLowerCase() == chr[VK_ALT_CTRL].toLowerCase())
       || (mode == VK_ALT_CTRL && chr[VK_SHIFT] && char.toLowerCase() == chr[VK_SHIFT].toLowerCase())) {
          css += " "+cssClasses.hiddenAlt;
      }

      html.push("<span");
      if (css) {
          html.push(" class=\""+css+"\"");
      }
      html.push(" >\xa0"+char+"\xa0</span>");
      return html.join("");
  }
  /**
   *  Keyboard initializer
   */
  ;(function() {
      /*
      *  create keyboard UI
      */
      nodes.keyboard = document.createElement('div');
      nodes.keyboard.unselectable = "on";
      nodes.keyboard.id = 'virtualKeyboard';
      nodes.keyboard.innerHTML =("<div id=\"kbDesk\"><!-- --></div>"
                                +"<select id=\"kb_langselector\"></select>"
                                +"<select id=\"kb_mappingselector\"></select>"
                                +'<div id="copyrights" nofocus="true"><a href="http://debugger.ru/projects/virtualkeyboard" target="_blank" title="&copy;2006-2009 Debugger.ru">VirtualKeyboard '+self.$VERSION$+'</a></div>'
                                ).replace(/(<\w+)/g,"$1 unselectable='on' ");
                                
      nodes.desk = nodes.keyboard.firstChild;

      var el = nodes.keyboard.childNodes.item(1);
      EM.addEventListener(el,'change', function(e){self.switchLayout(this.value)});
      nodes.langbox = el;

      var el = el.nextSibling
         ,mapGroup = "";

      keymap = DocumentCookie.get('vk_mapping');

      if (!keymaps.hasOwnProperty(keymap))
          keymap = 'QWERTY Standard';

      for (var i in keymaps) {
          var map = keymaps[i].split("").map(function(c){return c.charCodeAt(0)});
          /*
          *  add control keys
          */
          map.splice(14,0,8,9);
          map.splice(28,0,13,20);
          map.splice(41,0,16);
          map.splice(52,0,16,46,17,18,32,18,17);
          /*
          *  convert keymap array to the object, to have better typing speed
          */
          var tk = map;
          map = [];
          for (var z=0, kL=tk.length; z<kL; z++) {
              map[tk[z]] = z;
          }
          keymaps[i] = map;

          /*
          *  append mapping to the dropdown box
          */
          tk = i.split(" ",2);
          if (mapGroup.indexOf(mapGroup=tk[0])!=0) {
              el.appendChild(document.createElement('optgroup'))
              el.lastChild.label = mapGroup;
          }
          map = document.createElement('option');
          el.lastChild.appendChild(map);
          map.value = i;
          map.innerHTML = tk[1];
          map.selected = (i == keymap);
      }
      keymap = keymaps[keymap];
      EM.addEventListener(el,'change', switchMapping);

      /*
      *  attach some event handlers
      */
      EM.addEventListener(nodes.desk,'mousedown', _btnMousedown_);
      EM.addEventListener(nodes.desk,'mouseup', _btnClick_);
      EM.addEventListener(nodes.desk,'mouseover', _btnMouseInOut_);
      EM.addEventListener(nodes.desk,'mouseout', _btnMouseInOut_);
      EM.addEventListener(nodes.desk,'click', EM.preventDefaultAction);

      /*
      *  selection and reset of the selection in the target input
      *  Safari likes to have some checks against 'select' node
      */
      nodes.keyboard.onmousedown = function (e) {if (!e || !e.target.tagName || 'select' != e.target.tagName.toLowerCase()) return false}

      /*
      *  check url params for the default layout name
      */
      var opts = getScriptQuery('virtualkeyboard.js');
      options.layout = DocumentCookie.get('vk_layout') || opts.vk_layout || null;
  })();
}
/**
 *  Container for the custom language IMEs, don't mess with the window object
 *
 *  @type {Object}
 */
VirtualKeyboard.Langs = {};
/**
 *  Simple IME thing to show input tips, supplied by the callback
 *
 *  Usage:
 *   - call VirtualKeyboard.IME.show(suggestionlist); to show the suggestions
 *   - call VirtualKeyboard.IME.hide(keep_selection); to hide IME toolbar and keep selectio if needed
 *
 *  @scope public
 */
VirtualKeyboard.IME = new function () {
    var self = this;
    var html = "<div id=\"VirtualKeyboardIME\"><table><tr><td class=\"IMEControl\"><div class=\"left\"><!-- --></div></td>"
              +"<td class=\"IMEControl IMEContent\"></td>"
              +"<td class=\"IMEControl\"><div class=\"right\"><!-- --></div></td></tr>"
              +"<tr><td class=\"IMEControl IMEInfo\" colspan=\"3\"><div class=\"showAll\"><div class=\"IMEPageCounter\"></div><div class=\"arrow\"></div></div></td></tr></div>";
    var ime = null;
    var chars = "";
    var page = 0;
    var showAll = false;
    var sg = [];
    var target = null;
    var targetWindow = null;

    /**
     *  Shows the IME tooltip
     *
     *  @param {Array} s optional array of the suggestions
     *  @scope public
     */
    self.show = function (s) {
        target = VirtualKeyboard.getAttachedInput();
        var win = DOM.getWindow(target);
        /*
        *  if there's no IME or target window is not the same, as before - create new IME
        */
        if (targetWindow != win) {
            if (ime && ime.parentNode) {
                ime.parentNode.removeChild(ime);
            }
            targetWindow = win;
            __createImeToolbar();
            targetWindow.document.body.appendChild(ime);
        }
        /*
        *  external property, set in the #switchLayout
        */
        ime.className = self.css

        if (s) self.setSuggestions(s);
        if (target && ime && sg.length>0) {
            EM.addEventListener(target,'blur',self.blurHandler);
            ime.style.display = "block";
            self.updatePosition(target);
        } else if ('none' != ime.style.display) {
            self.hide();
        }
    }

    /**
     *  Hides IME
     *
     *  @param {Boolean} keep keeps selection
     *  @scope public
     */
    self.hide = function (keep) {
        if (ime && 'none' != ime.style.display) {
            ime.style.display = "none";
            EM.removeEventListener(target,'blur',self.blurHandler);
            if (target && DocumentSelection.getSelection(target) && !keep)
                DocumentSelection.deleteSelection(target);
            target = null;
            sg=[];
        }
    }
    /**
     *  Updates position of the IME tooltip
     *
     *  @scope public
     */
    self.updatePosition = function () {
        var xy = DOM.getOffset(target);
        ime.style.left = xy.x+'px';
        var co = DocumentSelection.getSelectionOffset(target);
        ime.style.top = xy.y+co.y+co.h+'px';
    }
    /**
     *  Imports suggestions and applies them
     *
     *  @scope public
     */
    self.setSuggestions = function (arr) {
        if (!isArray(arr)) return false;
        sg = arr;
        page = 0;
        showPage();
        self.updatePosition(target);
    }
    /**
     *  Returns suggestion list
     *
     *  @param {Number} idx optional index in the suggestions array
     *  @return {String, Array} all suggestions, or one by its index
     *  @scope public
     */
    self.getSuggestions = function (idx) {
        return isNumber(idx)?sg[idx]:sg;
    }
    /**
     *  Shows the next page from the suggestions list
     *
     *  @param {Event} e optional event to be cancelled
     *  @scope public
     */
    self.nextPage = function (e) {
        page = Math.max(Math.min(page+1,(Math.ceil(sg.length/10))-1),0);
        showPage();
    }
    /**
     *  Shows the previous page from the suggestions list
     *
     *  @param {Event} e optional event to be cancelled
     *  @scope public
     */
    self.prevPage = function (e) {
        page = Math.max(page-1,0);
        showPage();
    }
    /**
     *  Returns the current page number
     *
     *  @return {Number} page number
     *  @scope public
     */
    self.getPage = function () {
        return page;
    }
    /**
     *  Returns char by its number in the suggestions array
     *
     *  @param {Number} n char number in the current page
     *  @return {String} char
     *  @scope public
     */
    self.getChar = function (n) {
        n = --n<0?9:n;
        return sg[self.getPage()*10+n]
    }
    self.isOpen = function () {
        return ime && 'block' == ime.style.display;
    }
    /**
     *  Gets called on input field blur then closes IME toolbar and removes the selection
     *
     */
    self.blurHandler = function (e) {
        self.hide();
    }
    /**
     *  Toggles 'all' and 'paged' modes of the toolbar
     *
     *  @param {Event} e optional event to be cancelled
     *  @scope public
     */
    self.toggleShowAll = function (e) {
         var sa = ime.firstChild.rows[1].cells[0].lastChild;
         if (showAll = !showAll) {
             page = 0;
             sa.className = 'showPage';
         } else {
             sa.className = 'showAll';
         }
         showPage();
    }
    /**
     *  Shows currently selected page in the IME tooltip
     *
     *  @scope private
     */
    var showPage = function () {
        var s = ['<table>'];
        for (var z=0,pL=Math.ceil(sg.length/10); z<pL; z++ ) {
            if (showAll || z == page) {
                s.push('<tr>');
                for (var i=0,p=z*10; i<10 && !isUndefined(sg[p+i]); i++) {
                    s.push("<td><a href=''>")
                    if (z==page) {
                        s.push("<b>&nbsp;"+((i+1)%10)+": </b>");
                    } else {
                        s.push("<b>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</b>");
                    }
                    s.push(sg[p+i]+"</a></td>");
                }
                s.push('</tr>');
            }
        }
        s.push('</table>');
        ime.firstChild.rows[0].cells[1].innerHTML = s.join("");
        // update page counter
        ime.firstChild.rows[1].cells[0].firstChild.firstChild.innerHTML = (page+1)+"/"+(0+showAll || Math.ceil(sg.length/10));
        // prevent selection in IE
        var els = ime.getElementsByTagName("*");
        for (var i=0,eL=els.length; i<eL; i++) {
            els[i].unselectable = "on";
        }
    }
    /**
     *  Inserts selected choice, replacing possible selection and hides IME toolbar
     *
     *  @param {MousedownEvent} e
     *  @scope protected
     */
    var pasteSuggestion = function (e) {
        var el = DOM.getParent(e.target,'a');
        if (el) {
            DocumentSelection.insertAtCursor(target,el.lastChild.nodeValue);
            self.hide();
        }
        e.preventDefault();
    }

    /**
     *  Just the initializer
     */
    var __createImeToolbar = function () {
        var el = targetWindow.document.createElement('div');
        el.innerHTML = html;
        ime = el.firstChild;
        ime.style.display = 'none';
        var arrl = ime.firstChild.rows[0].cells[0]
           ,arrr = ime.firstChild.rows[0].cells[2]
           ,arrd = ime.firstChild.rows[1].cells[0].lastChild
        EM.addEventListener(arrl,'mousedown',self.prevPage);
        EM.addEventListener(arrl,'mousedown',EM.preventDefaultAction);
        EM.addEventListener(arrl,'mousedown',EM.stopPropagationAction);
        EM.addEventListener(arrr,'mousedown',self.nextPage);
        EM.addEventListener(arrr,'mousedown',EM.preventDefaultAction);
        EM.addEventListener(arrr,'mousedown',EM.stopPropagationAction);
        EM.addEventListener(arrd,'mousedown',self.toggleShowAll);
        EM.addEventListener(arrd,'mousedown',EM.preventDefaultAction);
        EM.addEventListener(arrd,'mousedown',EM.stopPropagationAction);
        /*
        *  blocks any selection
        */
        ime.unselectable = "on";
        var els = ime.getElementsByTagName("*");
        for (var i=0,eL=els.length;i<eL;i++) {
            els[i].unselectable = "on";
        }

        EM.addEventListener(ime,'mousedown',pasteSuggestion);
    }
}
