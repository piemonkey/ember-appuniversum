import Component from '@glimmer/component';
import AuIcon from './au-icon';
import { LoadingAnimation } from '../private/components/loading-animation';

const SKINS = [
  'primary',
  'secondary',
  'naked',
  'link',
  'link-secondary',
] as const;

export interface AuButtonSignature {
  Args: {
    alert?: boolean;
    disabled?: boolean;
    hideText?: boolean;
    icon?: string;
    iconAlignment?: 'left' | 'right';
    loading?: boolean;
    loadingMessage?: string;
    size?: 'large';
    skin?: (typeof SKINS)[number];
    width?: 'block';
    wrap?: boolean;
  };
  Blocks: {
    default: [];
  };
  Element: HTMLButtonElement;
}

export default class AuButton extends Component<AuButtonSignature> {
  get skin() {
    if (this.args.skin && SKINS.includes(this.args.skin)) return this.args.skin;
    else return 'primary';
  }

  get isDisabled() {
    return this.args.disabled || this.args.loading;
  }

  get sizeClass() {
    if (this.args.size == 'large' && !this.skin.startsWith('link'))
      return 'au-c-button--large';
    else return '';
  }

  get widthClass() {
    if (this.args.width == 'block') return 'au-c-button--block';
    else return '';
  }

  get skinClass() {
    return `au-c-button--${this.skin}`;
  }

  get alertClass() {
    if (this.args.alert) return 'au-c-button--alert';
    else return '';
  }

  get disabledClass() {
    if (this.isDisabled) return 'is-disabled';
    else return '';
  }

  get loadingClass() {
    if (this.args.loading) return 'is-loading';
    else return '';
  }

  get loadingMessage() {
    if (this.args.loadingMessage) return this.args.loadingMessage;
    else return 'Aan het laden';
  }

  get isIconLeft() {
    return !!this.args.icon && this.iconAlignment === 'left';
  }

  get isIconRight() {
    return !!this.args.icon && this.iconAlignment === 'right';
  }

  get iconAlignment() {
    if (this.args.iconAlignment) return this.args.iconAlignment;
    else return 'left';
  }

  get iconOnlyClass() {
    if (this.args.icon && this.args.hideText) return 'au-c-button--icon-only';
    return '';
  }

  <template>
    <button
      class="au-c-button
        {{this.widthClass}}
        {{this.sizeClass}}
        {{this.skinClass}}
        {{this.alertClass}}
        {{this.loadingClass}}
        {{this.disabledClass}}
        {{this.iconOnlyClass}}
        {{if @wrap 'au-c-button--wrap'}}"
      disabled={{this.isDisabled}}
      type="button"
      ...attributes
    >
      {{#unless @loading}}
        {{#if this.isIconLeft}}
          {{! @glint-expect-error: this.isIconLeft ensures that @icon is set }}
          <AuIcon @icon={{@icon}} />
        {{/if}}
      {{/unless}}

      {{#if @hideText}}
        {{#if @loading}}
          <span class="au-u-hidden-visually">{{this.loadingMessage}}</span>
          <LoadingAnimation />
        {{else}}
          <span class="au-u-hidden-visually">{{yield}}</span>
        {{/if}}
      {{else}}
        {{#if @loading}}
          {{this.loadingMessage}}
          <LoadingAnimation />
        {{else}}
          {{yield}}
        {{/if}}
      {{/if}}

      {{#unless @loading}}
        {{#if this.isIconRight}}
          {{! @glint-expect-error: this.isIconRight ensures that @icon is set }}
          <AuIcon @icon={{@icon}} />
        {{/if}}
      {{/unless}}
    </button>
  </template>
}
