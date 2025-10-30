import * as React from 'react';

import { CardReaderLiteViewProps } from './CardReaderLite.types';

export default function CardReaderLiteView(props: CardReaderLiteViewProps) {
  return (
    <div>
      <iframe
        style={{ flex: 1 }}
        src={props.url}
        onLoad={() => props.onLoad({ nativeEvent: { url: props.url } })}
      />
    </div>
  );
}
