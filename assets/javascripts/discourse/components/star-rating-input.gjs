import Component from "@glimmer/component";
import { tracked } from "@glimmer/tracking";
import { action } from "@ember/object";
import { on } from '@ember/modifier';
import { fn } from '@ember/helper';
import { htmlSafe } from '@ember/template';

export default class StarRatingInput extends Component {
  @tracked hoverRating = null;

  get stars() {
    return Array.from({ length: 5 }, (_, i) => i + 1);
  }

  starClass = (starValue) => {
    const isSelected = (this.args.currentRating != null && this.args.currentRating >= starValue) ||
      (this.hoverRating != null && this.hoverRating >= starValue);
    return `fa d-icon d-icon-star svg-icon svg-node star-icon ${isSelected ? 'selected' : ''}`.trim();
  }

  @action setRating(newRating) { /* ... logic ... */ if (this.args.currentRating === newRating) { this.args.onChange(this.args.dimension, null); } else { this.args.onChange(this.args.dimension, newRating); } }
  @action setHover(rating) { this.hoverRating = rating; }
  @action clearHover() { this.hoverRating = null; }

  get starSVG() { return htmlSafe(`<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 576 512"><path d="M316.9 18C311.6 7 300.4 0 288.1 0s-23.4 7-28.8 18L195 150.3 51.4 171.5c-12 1.8-22 10.2-25.7 21.7s-.7 24.2 7.9 32.7L137.8 329 113.2 474.7c-2 12 3 24.2 12.9 31.3s23 8 33.8 2.3l128.3-68.5 128.3 68.5c10.8 5.7 23.9 4.9 33.8-2.3s14.9-19.3 12.9-31.3L438.5 329 542.7 225.9c8.6-8.5 11.7-21.2 7.9-32.7s-13.7-19.9-25.7-21.7L381.2 150.3 316.9 18z"/></svg>`); }

  <template>
    <div class="star-rating-input" {{on "mouseleave" this.clearHover}}>
      {{#each this.stars as |starValue|}}
        <span class="star-icon-wrapper" role="button" tabindex="0" aria-label="Rate {{starValue}} out of 5 stars" {{on "mouseover" (fn this.setHover starValue)}} {{on "click" (fn this.setRating starValue)}} >
          <span class={{this.starClass starValue}}>{{{this.starSVG}}}</span>
        </span>
      {{/each}}
    </div>
  </template>
}
