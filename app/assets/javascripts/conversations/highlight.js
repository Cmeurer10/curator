// function highlightConvo(startIndex, endIndex, convoID, color){
//     selectAndHighlightRange("text", startIndex, endIndex, convoID, color)
// }

// function getTextNodesIn(node) {
//     var textNodes = [];
//     if (node.nodeType == 3) {
//         textNodes.push(node);
//     } else {
//         var children = node.childNodes;
//         for (var i = 0, len = children.length; i < len; ++i) {
//             textNodes.push.apply(textNodes, getTextNodesIn(children[i]));
//         }
//     }
//     return textNodes;
// }

// function setSelectionRange(el, start, end) {
//     if (document.createRange && window.getSelection) {
//         var range = document.createRange();
//         range.selectNodeContents(el);
//         var textNodes = getTextNodesIn(el);
//         var foundStart = false;
//         var charCount = 0, endCharCount;

//         for (var i = 0, textNode; textNode = textNodes[i++]; ) {
//             endCharCount = charCount + textNode.length;
//             if (!foundStart && start >= charCount && (start < endCharCount || (start == endCharCount && i <= textNodes.length))) {
//                 range.setStart(textNode, start - charCount);
//                 foundStart = true;
//             }
//             if (foundStart && end <= endCharCount) {
//                 range.setEnd(textNode, end - charCount);
//                 break;
//             }
//             charCount = endCharCount;
//         }

//         var sel = window.getSelection();
//         sel.removeAllRanges();
//         sel.addRange(range);
//     } else if (document.selection && document.body.createTextRange) {
//         var textRange = document.body.createTextRange();
//         textRange.moveToElementText(el);
//         textRange.collapse(true);
//         textRange.moveEnd("character", end);
//         textRange.moveStart("character", start);
//         textRange.select();
//     }
// }

// function makeEditableAndHighlight(colour, convo_id) {
//     sel = window.getSelection();
//     if (sel.rangeCount && sel.getRangeAt) {
//         range = sel.getRangeAt(0);
//     }
//     document.designMode = "on";
//     if (range) {
//         sel.removeAllRanges();
//         sel.addRange(range);
//     }
//     // Use HiliteColor since some browsers apply BackColor to the whole block
//     if (!document.execCommand("HiliteColor", false, colour)) {
//         document.execCommand("BackColor", false, colour);
//     }
//         var listId = window.getSelection().focusNode.parentNode;
//         $(listId).addClass("highlight");
//         $(listId).attr('id', "convo-" + convo_id);
//     document.designMode = "off";
// }


// function highlight(colour, convo_id) {
//     var range, sel;
//     if (window.getSelection) {
//         // IE9 and non-IE
//         try {
//             if (!document.execCommand("BackColor", false, colour)) {
//                 makeEditableAndHighlight(colour, convo_id);
//             }
//         } catch (ex) {
//             makeEditableAndHighlight(colour, convo_id)
//         }
//     } else if (document.selection && document.selection.createRange) {
//         // IE <= 8 case
//         range = document.selection.createRange();
//         range.execCommand("BackColor", false, colour);
//     }
// }

// function selectAndHighlightRange(id, start, end, convo_id, color) {
//     setSelectionRange(document.getElementById("text"), start, end);
//     highlight(color, convo_id);
// }