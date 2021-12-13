import axios from "axios"

// example usage:
// apiClient.get("/user/1")

export const apiClient = axios.create({
    baseURL: process.env.VUE_APP_API_URL,
})