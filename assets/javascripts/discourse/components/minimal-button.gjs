import Component from "@glimmer/component";
import { action } from "@ember/object";
import { service } from "@ember/service";
import DButton from "discourse/components/d-button";
import MinimalModal from "./minimal-modal"; // Import the minimal modal component

export default class MinimalButton extends Component {
  // Args: post
  @service modal;

  @action
  openModal() {
    console.log(`MinimalButton: openModal clicked for post ${this.args.post?.id}`);
    try {
      // Show the minimal modal component, passing minimal data
      // Make sure the model structure matches what MinimalModal expects if needed
      const modelData = { postId: this.args.post?.id };
      this.modal.show(MinimalModal, { model: modelData });
      console.log("MinimalButton: this.modal.show called successfully.");
    } catch (e) {
      console.error("MinimalButton: Error calling this.modal.show:", e);
      alert("Error trying to show modal. Check console.");
    }
  }

  <template>
    <DButton
      class="btn-default minimal-modal-btn"
      @action={{this.openModal}}
      @icon="bug" {{!-- Changed icon for clarity --}}
      @label="Test Failing Modal" {{!-- Changed label --}}
      title="Test Minimal Modal Render Error"
    />
  </template>
}
