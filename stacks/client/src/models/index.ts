export class User {
    uuid: string | null = null
    email: string | null = null
    name: string | null = null
    surname: string | null = null

    constructor(data?: any) {
        this.hydrate(data)
    }

    private hydrate(data?: any) {
        for (const prop in data) {

            if (Object.prototype.hasOwnProperty.call(this, prop) && Object.prototype.hasOwnProperty.call(data, prop)) {
                this[prop] = data[prop]
            }
        }
    }
}
