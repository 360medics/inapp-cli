export default (value: string | string[]): string => {
    return value[0].toUpperCase() + value.toString().substring(1)
}
