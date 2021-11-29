type reference = {
    text: string
    link: string
}
type Score = {
    id: number
    name: string
    subtitle: string
    appId: number
    parentId: null
    type: string
    content: string
    slug: string
    submenu: boolean
    reference: [reference]
}
type Scores = {
    id: number
    name: string
    subtitle: string
    appId: number
    parentId: null
    type: string
    content: string
    slug: string
    submenu: boolean
    children: [Score]
}

export { Scores, Score };
