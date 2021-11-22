export default (value: string | string[]): string => value[0].toUpperCase() + value.toString().substring(1);
