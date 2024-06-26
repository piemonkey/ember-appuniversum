import { on } from '@ember/modifier';
import { action } from '@ember/object';
import Component from '@glimmer/component';
import { tracked } from '@glimmer/tracking';
import AuIcon from './au-icon';

export interface AuAlertSignature {
  Args: {
    closable?: boolean;
    icon?: string;
    iconVisible?: boolean;
    onClose?: () => void;
    size?: 'tiny' | 'small';
    skin?: 'info' | 'success' | 'warning' | 'error';
    title?: string;
  };
  Blocks: {
    default: [];
  };
  Element: HTMLDivElement;
}

export default class AuAlert extends Component<AuAlertSignature> {
  @tracked isVisible = true;

  get skin() {
    const { skin } = this.args;

    if (skin === 'info') return 'au-c-alert--info';
    if (skin === 'success') return 'au-c-alert--success';
    if (skin == 'warning') return 'au-c-alert--warning';
    if (skin == 'error') return 'au-c-alert--error';
    return '';
  }

  get size() {
    const { size } = this.args;
    if (size === 'tiny') return 'au-c-alert--tiny';
    if (size === 'small') return 'au-c-alert--small';
    return '';
  }

  @action
  closeAlert() {
    this.isVisible = false;

    this.args.onClose?.();
  }

  <template>
    {{#if this.isVisible}}
      <div
        class="au-c-alert {{this.skin}} {{this.size}}"
        role="alert"
        ...attributes
      >
        {{#if @icon}}
          <div
            class="au-c-alert__icon"
            aria-hidden={{if @iconVisible "false" "true"}}
            data-test-alert-icon
          >
            <AuIcon @icon={{@icon}} />
          </div>
        {{/if}}
        <div class="au-c-alert__content">
          {{#if @title}}
            <p class="au-c-alert__title" data-test-alert-title>{{@title}}</p>
          {{/if}}
          <div
            class="au-c-alert__message"
            data-test-alert-message
          >{{yield}}</div>
        </div>
        {{#if @closable}}
          <button
            class="au-c-alert__close"
            type="button"
            data-test-alert-close
            {{on "click" this.closeAlert}}
          >
            <AuIcon @icon="cross" @size="large" />
            <span class="au-u-hidden-visually">Sluit</span>
          </button>
        {{/if}}
      </div>
    {{/if}}
  </template>
}
