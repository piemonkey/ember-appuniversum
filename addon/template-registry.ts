import type AuAlert from '@appuniversum/ember-appuniversum/components/au-alert';
import type AuApp from '@appuniversum/ember-appuniversum/components/au-app';
import type AuBadge from '@appuniversum/ember-appuniversum/components/au-badge';
import type AuBodyContainer from '@appuniversum/ember-appuniversum/components/au-body-container';
import type AuIcon from '@appuniversum/ember-appuniversum/components/au-icon';

export default interface AppuniversumRegistry {
  AuAlert: typeof AuAlert;
  AuApp: typeof AuApp;
  AuBadge: typeof AuBadge;
  AuBodyContainer: typeof AuBodyContainer;
  AuIcon: typeof AuIcon;
}
