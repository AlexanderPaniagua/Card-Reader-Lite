import { NativeModule, requireNativeModule } from 'expo';

import { CardReaderLiteModuleEvents } from './CardReaderLite.types';

declare class CardReaderLiteModule extends NativeModule<CardReaderLiteModuleEvents> {
  PI: number;
  hello(): string;
  setValueAsync(value: string): Promise<void>;
}

// This call loads the native module object from the JSI.
export default requireNativeModule<CardReaderLiteModule>('CardReaderLite');
