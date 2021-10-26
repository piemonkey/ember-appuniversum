import { action } from '@ember/object';
import Component from "@glimmer/component";
const LANDMARKS = [
    'aside',
    'footer',
    'form',
    'header',
    'main',
    'nav'
];
export default class AuModal extends Component {

  get destinationElement() {
    return document.getElementById("ember-appuniversum-wormhole");
  }

  get size() {
    if (this.args.size === "fullscreen")
      return "au-c-modal--fullscreen";
      if (this.args.size === "large")
      return "au-c-modal--large";
    else
      return "";
  }

  @action
  setInert(toggle) {
    let landmarkElements = document.querySelectorAll(LANDMARKS);

    this.destinationElement.inert = toggle;

    landmarkElements.forEach(function (landmarkElement) {
      if (landmarkElement.parentElement === document.body) {
        landmarkElement.inert = !toggle;
      }
    });

  }

  @action
  closeModal() {
    // Prevent that the @closeModal action is run more than once.
    // {{focus-trap}} calls closeModal when it is deactivated which also happens when the element it is attached to is destroyed.
    // This means that this method will be called twice if the user closes the modal with something else than the escape button.
    // (once by the click handler of the close button and once when {{focus-trap}} deactivates)
    // It would be better if focus-trap exposed events that would be called when Escape is pressed, or the user clicks outside of the trap
    // That way we replace `onDeactivate` with those events and this check wouldn't be needed anymore.
    //
    // More information: https://github.com/josemarluedke/ember-focus-trap/issues/36#issuecomment-850844483
    // new focus-trap events issue: https://github.com/focus-trap/focus-trap/issues/126
    if (!this.isDestroying && this.args.modalOpen) {
      this.setInert(true);
      this.args.closeModal?.();
    }
  }
}
