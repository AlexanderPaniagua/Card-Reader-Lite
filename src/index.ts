import { requireNativeModule } from 'expo-modules-core';
const CardReaderLite = requireNativeModule('CardReaderLite');

export async function scanCard() {
  return await CardReaderLite.scanCard();
}