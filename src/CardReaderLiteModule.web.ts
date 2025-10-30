import { registerWebModule, NativeModule } from 'expo';

import { CardReaderLiteModuleEvents } from './CardReaderLite.types';

class CardReaderLiteModule extends NativeModule<CardReaderLiteModuleEvents> {
  PI = Math.PI;
  async setValueAsync(value: string): Promise<void> {
    this.emit('onChange', { value });
  }
  hello() {
    return 'Hello world! 👋';
  }
}

export default registerWebModule(CardReaderLiteModule, 'CardReaderLiteModule');
