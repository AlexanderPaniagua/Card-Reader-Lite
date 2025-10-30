import { requireNativeView } from 'expo';
import * as React from 'react';

import { CardReaderLiteViewProps } from './CardReaderLite.types';

const NativeView: React.ComponentType<CardReaderLiteViewProps> =
  requireNativeView('CardReaderLite');

export default function CardReaderLiteView(props: CardReaderLiteViewProps) {
  return <NativeView {...props} />;
}
