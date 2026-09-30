import 'dart:html' as html;

class DomHelper {
  static const String statusId = 'dart-dom-status';

  // ==========================================================
  // CHANGE BROWSER PAGE TITLE
  // ==========================================================

  static void setPageTitle(String title) {
    html.document.title = title;
  }

  // ==========================================================
  // CREATE / UPDATE DOM ELEMENT
  // ==========================================================

  static void updateStatus(String message) {
    html.Element? element =
        html.document.getElementById(statusId);

    // If the element does not exist,
    // create a new DOM element.
    if (element == null) {
      element = html.DivElement()
        ..id = statusId
        ..text = message;

      // Modify its CSS directly through the DOM.
      element.style
        ..position = 'fixed'
        ..bottom = '20px'
        ..right = '20px'
        ..padding = '12px 18px'
        ..backgroundColor = '#0F172A'
        ..color = 'white'
        ..borderRadius = '12px'
        ..fontFamily = 'Arial'
        ..fontSize = '14px'
        ..zIndex = '99999'
        ..boxShadow =
            '0 6px 20px rgba(0,0,0,0.18)';

      // Add the newly created element to the DOM.
      html.document.body?.append(element);
    } else {
      // Update existing DOM element.
      element.text = message;
    }
  }

  // ==========================================================
  // UPDATE ELEMENT TEXT
  // ==========================================================

  static void updateElementText(
    String id,
    String text,
  ) {
    final element =
        html.document.getElementById(id);

    if (element != null) {
      element.text = text;
    }
  }

  // ==========================================================
  // TOGGLE CSS CLASS
  // ==========================================================

  static void toggleClass(
    String id,
    String className,
  ) {
    final element =
        html.document.getElementById(id);

    if (element != null) {
      element.classes.toggle(className);
    }
  }

  // ==========================================================
  // REMOVE DOM ELEMENT
  // ==========================================================

  static void removeElement(String id) {
    final element =
        html.document.getElementById(id);

    element?.remove();
  }
}
