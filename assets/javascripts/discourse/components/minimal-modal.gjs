import Component from "@glimmer/component";
import DModal from "discourse/components/d-modal";
import DButton from "discourse/components/d-button";
import StarRatingInput from "./star-rating-input"; // Import the child
import { action } from "@ember/object";
import { tracked } from "@glimmer/tracking"; // Keep tracked for dummy state
// Keep necessary built-in helper/modifier imports if template still uses them
import { on, preventDefault } from '@ember/modifier';
import { fn, mut } from '@ember/helper';
import { if as conditional } from '@ember/helper';
import { eq } from '@ember/helper';

export default class MinimalModal extends Component {
  // Args received: model { postId }, closeModal

  // Dummy state and action for StarRatingInput binding
  @tracked testRating = null;
  @tracked isSubmitting = false; // For button icon test

  @action
  updateTestRating(dimension, value) {
    console.log(`MinimalModal received rating: ${dimension}=${value}`);
    this.testRating = value;
  }

  get modalTitle() { return "Minimal Modal - Failing with StarRatingInput"; }
  get cancelLabel() { return "Cancel"; }
  get submitLabel() { return "Submit"; }
  get isSubmitDisabled() { return this.isSubmitting; }
  get testRatingLabel() { return "Test Rating"; }
  ratingOptions = [1, 2, 3, 4, 5]; // Needed for StarRatingInput internal logic? No.


  @action closeModal() { if(this.args.closeModal) this.args.closeModal(); }
  @action dummySubmit() { console.log("Minimal Modal Submit"); this.closeModal(); }

// {{!-- TEMPLATE THAT INVOKES StarRatingInput and should FAIL --}}
<template>
  <DModal @title={{this.modalTitle}} @closeModal={{this.closeModal}} class="feedback-form-modal-minimal-fail">
    <:body>
      <p>Attempting to render StarRatingInput:</p>
      {{!-- Invoking the child component triggers the error --}}
      <fieldset class="form-section">
        <legend>{{this.testRatingLabel}}</legend>
        <StarRatingInput @dimension="test" @currentRating={{this.testRating}} @onChange={{this.updateTestRating}} />
      </fieldset>

      {{!-- Add back radio button with EQ helper just to ensure it's present --}}
      <fieldset class="form-section radios"> <legend>Test EQ Helper</legend> {{#each this.ratingOptions as |ratingValue|}} <label><input type="radio" name="testEqRating" value={{ratingValue}} checked={{eq this.testRating ratingValue}} {{on "change" (fn this.updateTestRating "testEq")}}> {{ratingValue}}</label> {{/each}} </fieldset>

    </:body>
    <:footer>
      <DButton @action={{this.closeModal}} class="btn-flat"> {{this.cancelLabel}} </DButton>
      {{!-- Include the conditional icon again --}}
      <DButton @action={{this.dummySubmit}} @disabled={{this.isSubmitDisabled}} class="btn-primary" @icon={{if this.isSubmitting "spinner"}}>
        {{this.submitLabel}}
      </DButton>
    </:footer>
  </DModal>
</template>
}
