# :rabbit: 감정 분석 & 위로 챗봇, 토닥토닥 :ambulance:

## :computer: 프로젝트 소개

### :question: 왜 "토닥토닥"인가요?

- 사용자를 토닥토닥 위로해주는 토끼 닥터라는 중의적 의미 입니다.
- 사용자가 작성한 텍스트를 통해 감정을 분석하고,
- 분석한 감정에 대해 격려 또는 위로를 해줍니다.

### :star2: 특징

- 직접 채팅을 칠 필요 없이 음성으로 일기 작성이 가능합니다.
- 작성한 일기를 통해 그날의 감정을 파악할 수 있습니다.
- 일기에 대한 감정을 그래프를 통해 시각화하여 제공합니다.

<br />

### :wind_chime: 주요 기능

    * 📝 STT (Speech To Text)
    * 😃 감정 분석 (기쁨, 슬픔, 우울, 분노, 불안, 일상)
    * 💆‍♀️ 감성 채팅
    * 📢 TTS (Text To Speech)

<br />

### :beginner: 주요 기술

    * Front *
    - STT
    - TTS

    * Back *
    - JPA
    - Security

    * AI *
    - NLP
    - Deep Learning

<br />

### 🔨 기술 스택

:heart: **Front End**
<img src="https://img.shields.io/badge/HTML5-E34F26?style=flat&logo=HTML5&logoColor=white"/> 
<img src="https://img.shields.io/badge/CSS-1572B6?style=flat&logo=CSS3&logoColor=white"/> 
<img src="https://img.shields.io/badge/JS-F7DF1E?style=flat&logo=JavaScript&logoColor=white"/> 
<img src="https://img.shields.io/badge/Flutter-02569B?style=flat&logo=Flutter&logoColor=white"/> 
<img  src="https://img.shields.io/badge/node.js-339933?style=flat&logo=Node.js&logoColor=white">
<img src="https://img.shields.io/badge/Figma-00C4B7?style=flat&logo=Figma&logoColor=white"/> 
<img src="https://img.shields.io/badge/styled components-DB7093?style=flat&logo=styled-components&logoColor=white"/> 
<img src="https://img.shields.io/badge/mui-007FFF?style=flat&logo=mui&logoColor=white"/> 
![Recoil](https://img.shields.io/badge/Recoil-ffd966?style=flat&logo=data:image/svg+xml;base64,PHN2ZyB4bWxucz0iaHR0cDovL3d3dy53My5vcmcvMjAwMC9zdmciICB2aWV3Qm94PSIwIDAgNDggNDgiIHdpZHRoPSIyNDBweCIgaGVpZ2h0PSIyNDBweCI+PHBhdGggZmlsbD0iIzIxMjEyMSIgZD0iTTE4Ljg2OSwyMC45MmMwLjM1Ny0wLjA3NSwwLjcyNC0wLjEyOCwxLjA5MS0wLjE2bDAsMGwwLDBsMi44NTMtMC4yNzFsLTMuODc1LTQuMjQ4IGMtMS4xNjYtMS4yODMtMS44MS0yLjk0NC0xLjgxLTQuNjc5aC0zLjIwNWMwLDIuNTM0LDAuOTQyLDQuOTY3LDIuNjUxLDYuODRMMTguODY5LDIwLjkyeiIvPjxwYXRoIGZpbGw9IiMyMTIxMjEiIGQ9Ik0yOC44NzcsMjcuMTQzYy0wLjI4NywwLjA1My0wLjU4LDAuMDktMC44NzMsMC4xMjJsMCwwbDAsMGwtMy4wODgsMC4yOTNsMy44NjUsNC4yMzcgYzEuMTY2LDEuMjgzLDEuODEsMi45NDQsMS44MSw0LjY3OWgzLjIxYzAtMi41MzQtMC45NDItNC45NjEtMi42NTEtNi44NEwyOC44NzcsMjcuMTQzeiIvPjxwYXRoIGZpbGw9IiMyMTIxMjEiIGQ9Ik0zNC4xODQsMTcuNzI3Yy0wLjUyNy0yLjYxOS0yLjU4Mi00LjUyNS01LjIzMy00Ljg2bC0wLjQ5LTAuMDY0IGMtMS42NTYtMC4yMDgtMi45MDctMS42MjQtMi45MDctMy4yOVY3LjgwNGMxLjQ2OS0wLjYxMiwyLjUwMi0yLjA2LDIuNTAyLTMuNzQ4QzI4LjA1NywxLjgxNSwyNi4yNDIsMCwyNC4wMDEsMCBzLTQuMDU2LDEuODE1LTQuMDU2LDQuMDU2YzAsMS42NSwwLjk5LDMuMDcyLDIuNDA2LDMuNzA1djEuNzUxYzAsMy4yODQsMi40NTQsNi4wNjksNS43MTIsNi40NzNsMC40OSwwLjA2NCBjMS41MjgsMC4xOTIsMi4yODksMS4zMiwyLjQ5MSwyLjMxcy0wLjA1OSwyLjMyNi0xLjM5NSwzLjA5OGMtMC42NTUsMC4zNzgtMS4zNjMsMC42MDctMi4xMTMsMC42NzZsLTcuMzYyLDAuNjkyIGMtMS4yMTQsMC4xMTctMi4zNjQsMC40ODQtMy40MTgsMS4wOTFjLTIuMzE2LDEuMzQxLTMuNDcxLDMuODk3LTIuOTM4LDYuNTE2YzAuNTI3LDIuNjE5LDIuNTgyLDQuNTI1LDUuMjMzLDQuODZsMC40OSwwLjA2NCBjMS42NTYsMC4yMDgsMi45MDcsMS42MjQsMi45MDcsMy4yOXYxLjU1NGMtMS40NjQsMC42MTItMi40OTEsMi4wNi0yLjQ5MSwzLjc0MmMwLDIuMjQxLDEuODE1LDQuMDU2LDQuMDU2LDQuMDU2IHM0LjA1Ni0xLjgxNSw0LjA1Ni00LjA1NmMwLTEuNjU2LTAuOTk1LTMuMDgyLTIuNDE3LTMuNzF2LTEuNTg2YzAtMy4yODQtMi40NTQtNi4wNjktNS43MTItNi40NzNsLTAuNDktMC4wNjQgYy0xLjUyOC0wLjE5Mi0yLjI4OS0xLjMyLTIuNDkxLTIuMzFjLTAuMjAyLTAuOTksMC4wNTktMi4zMjYsMS4zOTUtMy4wOThjMC42NTUtMC4zNzgsMS4zNjMtMC42MDcsMi4xMTMtMC42NzZsNy4zNjItMC42OTIgYzEuMjE0LTAuMTE3LDIuMzY0LTAuNDg0LDMuNDE4LTEuMDkxQzMzLjU2MiwyMi45MDEsMzQuNzExLDIwLjM0NiwzNC4xODQsMTcuNzI3eiIvPjwvc3ZnPg==)

:blue_heart: **Back End**
![Java](https://img.shields.io/badge/Java-f0f0ff?style=flat&logo=data:image/svg+xml;base64,PHN2ZyB4bWxucz0iaHR0cDovL3d3dy53My5vcmcvMjAwMC9zdmciICB2aWV3Qm94PSIwIDAgNDggNDgiIHdpZHRoPSI0ODBweCIgaGVpZ2h0PSI0ODBweCI+PHBhdGggZmlsbD0iI0Y0NDMzNiIgZD0iTTIzLjY1LDI0Ljg5OGMtMC45OTgtMS42MDktMS43MjItMi45NDMtMi43MjUtNS40NTVDMTkuMjI5LDE1LjIsMzEuMjQsMTEuMzY2LDI2LjM3LDMuOTk5YzIuMTExLDUuMDg5LTcuNTc3LDguMjM1LTguNDc3LDEyLjQ3M0MxNy4wNywyMC4zNywyMy42NDUsMjQuODk4LDIzLjY1LDI0Ljg5OHoiLz48cGF0aCBmaWxsPSIjRjQ0MzM2IiBkPSJNMjMuODc4LDE3LjI3Yy0wLjE5MiwyLjUxNiwyLjIyOSwzLjg1NywyLjI5OSw1LjY5NWMwLjA1NiwxLjQ5Ni0xLjQ0NywyLjc0My0xLjQ0NywyLjc0M3MyLjcyOC0wLjUzNiwzLjU3OS0yLjgxOGMwLjk0NS0yLjUzNC0xLjgzNC00LjI2OS0xLjU0OC02LjI5OGMwLjI2Ny0xLjkzOCw2LjAzMS01LjU0Myw2LjAzMS01LjU0M1MyNC4zMTEsMTEuNjExLDIzLjg3OCwxNy4yN3oiLz48Zz48cGF0aCBmaWxsPSIjMTU2NUMwIiBkPSJNMzIuMDg0IDI1LjA1NWMxLjc1NC0uMzk0IDMuMjMzLjcyMyAzLjIzMyAyLjAxIDAgMi45MDEtNC4wMjEgNS42NDMtNC4wMjEgNS42NDNzNi4yMjUtLjc0MiA2LjIyNS01LjUwNUMzNy41MjEgMjQuMDUzIDM0LjQ2NCAyMy4yNjYgMzIuMDg0IDI1LjA1NXpNMjkuMTI5IDI3LjM5NWMwIDAgMS45NDEtMS4zODMgMi40NTgtMS45MDItNC43NjMgMS4wMTEtMTUuNjM4IDEuMTQ3LTE1LjYzOC4yNjkgMC0uODA5IDMuNTA3LTEuNjM4IDMuNTA3LTEuNjM4cy03Ljc3My0uMTEyLTcuNzczIDIuMTgxQzExLjY4MyAyOC42OTUgMjEuODU4IDI4Ljg2NiAyOS4xMjkgMjcuMzk1eiIvPjxwYXRoIGZpbGw9IiMxNTY1QzAiIGQ9Ik0yNy45MzUsMjkuNTcxYy00LjUwOSwxLjQ5OS0xMi44MTQsMS4wMi0xMC4zNTQtMC45OTNjLTEuMTk4LDAtMi45NzQsMC45NjMtMi45NzQsMS44ODljMCwxLjg1Nyw4Ljk4MiwzLjI5MSwxNS42MywwLjU3MkwyNy45MzUsMjkuNTcxeiIvPjxwYXRoIGZpbGw9IiMxNTY1QzAiIGQ9Ik0xOC42ODYsMzIuNzM5Yy0xLjYzNiwwLTIuNjk1LDEuMDU0LTIuNjk1LDEuODIyYzAsMi4zOTEsOS43NiwyLjYzMiwxMy42MjcsMC4yMDVsLTIuNDU4LTEuNjMyQzI0LjI3MSwzNC40MDQsMTcuMDE0LDM0LjU3OSwxOC42ODYsMzIuNzM5eiIvPjxwYXRoIGZpbGw9IiMxNTY1QzAiIGQ9Ik0zNi4yODEsMzYuNjMyYzAtMC45MzYtMS4wNTUtMS4zNzctMS40MzMtMS41ODhjMi4yMjgsNS4zNzMtMjIuMzE3LDQuOTU2LTIyLjMxNywxLjc4NGMwLTAuNzIxLDEuODA3LTEuNDI3LDMuNDc3LTEuMDkzbC0xLjQyLTAuODM5QzExLjI2LDM0LjM3NCw5LDM1LjgzNyw5LDM3LjAxN0M5LDQyLjUyLDM2LjI4MSw0Mi4yNTUsMzYuMjgxLDM2LjYzMnoiLz48cGF0aCBmaWxsPSIjMTU2NUMwIiBkPSJNMzksMzguNjA0Yy00LjE0Niw0LjA5NS0xNC42NTksNS41ODctMjUuMjMxLDMuMDU3QzI0LjM0MSw0Ni4xNjQsMzguOTUsNDMuNjI4LDM5LDM4LjYwNHoiLz48L2c+PC9zdmc+) <img src="https://img.shields.io/badge/Spring-6DB33F?style=flat&logo=Spring&logoColor=white"/> <img src="https://img.shields.io/badge/Spring Boot-6DB33F?style=flat&logo=Spring Boot&logoColor=white"/> ![JPA](https://img.shields.io/badge/JPA-696969?style=flat&logo=data:image/svg+xml;base64,PD94bWwgdmVyc2lvbj0iMS4wIiBlbmNvZGluZz0idXRmLTgiPz4NCjwhLS0gVXBsb2FkZWQgdG86IFNWRyBSZXBvLCB3d3cuc3ZncmVwby5jb20sIEdlbmVyYXRvcjogU1ZHIFJlcG8gTWl4ZXIgVG9vbHMgLS0+DQo8c3ZnIGZpbGw9IiMwMDAwMDAiIHdpZHRoPSI4MDBweCIgaGVpZ2h0PSI4MDBweCIgdmlld0JveD0iMCAtOCA0OCA0OCIgdmVyc2lvbj0iMS4xIiB4bWxucz0iaHR0cDovL3d3dy53My5vcmcvMjAwMC9zdmciPg0KPHRpdGxlPmpwYTwvdGl0bGU+DQo8cGF0aCBkPSJNNS4wNjMgMTMuNTMxYy0wLjA5NCAwLTAuMTI1LTAuMDMxLTAuMTg4LTAuMDYzLTAuMDMxLTAuMDYzLTAuMDMxLTAuMTI1LTAuMDMxLTAuMjE5czAtMC4xODggMC4wMzEtMC4yMTljMC4wNjMtMC4wNjMgMC4wOTQtMC4wOTQgMC4xODgtMC4wOTQgMC4wNjMgMCAwLjEyNSAwLjAzMSAwLjE1NiAwLjA5NCAwLjAzMSAwLjAzMSAwLjA2MyAwLjEyNSAwLjA2MyAwLjIxOXMtMC4wMzEgMC4xNTYtMC4wNjMgMC4yMTljLTAuMDMxIDAuMDMxLTAuMDk0IDAuMDYzLTAuMTU2IDAuMDYzek04LjQwNiA5Ljk2OWMtMC4wMzEgMC0wLjA5NCAwLTAuMTI1LTAuMDMxLTAuMDYzLTAuMDMxLTAuMDk0LTAuMTI1LTAuMDk0LTAuMjE5IDAtMC4wNjMgMC4wMzEtMC4xMjUgMC4wMzEtMC4xODggMC4wMzEtMC4wNjMgMC4wOTQtMC4xMjUgMC4xODgtMC4xMjVzMC4xMjUgMC4wMzEgMC4xNTYgMC4wOTQgMC4wNjMgMC4xMjUgMC4wNjMgMC4xODgtMC4wMzEgMC4xNTYtMC4wNjMgMC4yMTktMC4wOTQgMC4wNjMtMC4xNTYgMC4wNjN6TTcuMzEzIDEzLjU2M2MtMC4wMzEgMC0wLjA2MyAwLTAuMDk0LTAuMDMxIDAgMC0wLjAzMS0wLjAzMS0wLjAzMS0wLjA5NCAwLTAuMDMxIDAuMDMxLTAuMDYzIDAuMDYzLTAuMDk0czAuMDYzLTAuMDMxIDAuMTI1LTAuMDMxbDAuMDYzLTAuMDMxaDAuMDYzbDAuMDMxLTAuMDMxdjAuMDk0YzAgMC4wOTQtMC4wMzEgMC4xNTYtMC4wNjMgMC4xODhzLTAuMDk0IDAuMDMxLTAuMTU2IDAuMDMxek0yLjI4MSAxMy4yMTloLTAuMzQ0bDAuMTU2LTAuNXpNNy40MDYgOS43NWgwLjAzMWMwLjAzMSAwIDAuMDYzLTAuMDMxIDAuMDk0LTAuMDMxaDAuMDMxdjAuMDYzYzAgMC4wOTQtMC4wMzEgMC4xNTYtMC4wNjMgMC4xODgtMC4wNjMgMC4wMzEtMC4wOTQgMC4wMzEtMC4xNTYgMC4wMzFoLTAuMDk0YzAtMC4wMzEtMC4wMzEtMC4wNjMtMC4wMzEtMC4wOTQgMC0wLjA2MyAwLjAzMS0wLjA5NCAwLjA2My0wLjEyNSAwLjAzMSAwIDAuMDYzLTAuMDMxIDAuMTI1LTAuMDMxek04LjUgMTEuMjE5Yy0wLjAzMSAwLjAzMS0wLjA2MyAwLjAzMS0wLjEyNSAwLjAzMWgtMC4yNXYtMC4zNzVoMC4yNWMwLjA2MyAwIDAuMDk0IDAuMDMxIDAuMTI1IDAuMDYzIDAuMDYzIDAgMC4wNjMgMC4wNjMgMC4wNjMgMC4xMjVzMCAwLjEyNS0wLjA2MyAwLjE1NnpNOS4zNDQgMTEuMTg4YzAuMDYzIDAgMC4wOTQgMCAwLjE1NiAwLjAzMSAwLjAzMSAwLjAzMSAwLjA2MyAwLjA5NCAwLjA2MyAwLjE1NmgtMC40MzhjMC0wLjA2MyAwLjAzMS0wLjEyNSAwLjA2My0wLjE1NnMwLjA5NC0wLjAzMSAwLjE1Ni0wLjAzMXpNOS4zNDQgMTIuOTM4YzAuMDYzIDAgMC4xMjUgMC4wMzEgMC4xNTYgMC4wOTQgMC4wMzEgMC4wMzEgMC4wNjMgMC4xMjUgMC4wNjMgMC4yMTlzLTAuMDMxIDAuMTU2LTAuMDYzIDAuMjE5Yy0wLjAzMSAwLjAzMS0wLjA5NCAwLjA2My0wLjE1NiAwLjA2My0wLjA5NCAwLTAuMTU2LTAuMDMxLTAuMTg4LTAuMDYzLTAuMDMxLTAuMDYzLTAuMDYzLTAuMTI1LTAuMDYzLTAuMjE5czAuMDMxLTAuMTg4IDAuMDYzLTAuMjE5YzAuMDMxLTAuMDYzIDAuMDk0LTAuMDk0IDAuMTg4LTAuMDk0ek0xMS42ODggOC42NTZoMjcuMTI1YzUuMjgxIDAgOS41MzEgMy43NSA5LjUzMSA4LjM0NHYxMC4xNTZoLTM1LjA2M2MtNS4yNSAwLTkuNTMxLTMuNzE5LTkuNTMxLTguMzEzdi0zLjA2M2MtMi4xODgtMC44MTMtMy43NS0yLjc1LTMuNzUtNS4wMzEgMC0zLjAzMSAyLjcxOS01LjQ2OSA2LjA2My01LjQ2OSAyLjU2MyAwIDQuNzE5IDEuNDA2IDUuNjI1IDMuMzc1ek0xMC4xNTYgOS4yMTloLTAuMjE5djAuOTM4aDAuMjV2LTAuNjU2YzAuMDMxLTAuMDYzIDAuMDk0LTAuMDk0IDAuMTg4LTAuMDk0IDAuMDYzIDAgMC4wOTQgMC4wMzEgMC4xMjUgMC4wNjNzMC4wMzEgMC4wNjMgMC4wMzEgMC4xMjV2MC41NjNoMC4yNXYtMC42MjVjMC0wLjEyNS0wLjAzMS0wLjIxOS0wLjA5NC0wLjI1LTAuMDYzLTAuMDYzLTAuMTU2LTAuMDk0LTAuMjUtMC4wOTQtMC4wNjMgMC0wLjEyNSAwLjAzMS0wLjE4OCAwLjA2M2wtMC4wOTQgMC4wOTR2LTAuMTI1ek0xMC41IDEzLjAzMWMwLjAzMSAwLjAzMSAwLjAzMSAwLjA2MyAwLjAzMSAwLjA5NHYwLjU5NGgwLjI1di0wLjY1NmMwLTAuMDk0LTAuMDMxLTAuMTg4LTAuMDk0LTAuMjUtMC4wNjMtMC4wMzEtMC4xNTYtMC4wNjMtMC4yNS0wLjA2My0wLjA2MyAwLTAuMTI1IDAtMC4xODggMC4wNjMtMC4wMzEgMC0wLjA2MyAwLjA2My0wLjA5NCAwLjA5NHYtMC4xMjVoLTAuMjE5djAuOTM4aDAuMjV2LTAuNjU2YzAuMDMxLTAuMDYzIDAuMDk0LTAuMTI1IDAuMTg4LTAuMTI1IDAuMDYzIDAgMC4wOTQgMC4wMzEgMC4xMjUgMC4wOTR6TTEwLjUzMSAxMC42NTZ2MS4yODFoMC4yNXYtMS4yODFoLTAuMjV6TTEwLjEyNSAxMWgtMC4yMTl2MC45MzhoMC4yNXYtMC40MzhjMC0wLjA5NCAwLTAuMTU2IDAuMDMxLTAuMTg4IDAuMDMxLTAuMDYzIDAuMDk0LTAuMDk0IDAuMTg4LTAuMDk0aDAuMDYzdi0wLjI1aC0wLjAzMWMtMC4wNjMgMC0wLjEyNSAwLjAzMS0wLjE4OCAwLjA2MyAwIDAuMDMxLTAuMDYzIDAuMDYzLTAuMDk0IDAuMTI1di0wLjE1NnpNOS40NjkgOS40MDZjMC4wMzEgMC4wMzEgMC4wNjMgMC4wNjMgMC4wNjMgMC4wOTRzLTAuMDMxIDAuMDYzLTAuMDYzIDAuMDYzLTAuMDYzIDAuMDMxLTAuMDk0IDAuMDMxaC0wLjA5NGMtMC4wOTQgMC4wMzEtMC4xNTYgMC4wMzEtMC4yMTkgMC4wNjMtMC4wOTQgMC4wNjMtMC4xMjUgMC4xMjUtMC4xMjUgMC4yNSAwIDAuMDk0IDAuMDMxIDAuMTU2IDAuMDk0IDAuMjE5IDAuMDMxIDAuMDMxIDAuMTI1IDAuMDYzIDAuMTg4IDAuMDYzIDAuMDk0IDAgMC4xNTYgMCAwLjE4OC0wLjAzMSAwLjA2My0wLjAzMSAwLjA5NC0wLjA2MyAwLjEyNS0wLjA5NHYwLjA2M2MwIDAgMCAwLjAzMSAwLjAzMSAwLjAzMWgwLjI1di0wLjAzMXMtMC4wMzEgMC0wLjAzMS0wLjAzMXYtMC41OTRjMC0wLjEyNS0wLjA2My0wLjE4OC0wLjEyNS0wLjI1LTAuMDk0LTAuMDMxLTAuMTg4LTAuMDYzLTAuMjgxLTAuMDYzLTAuMTU2IDAtMC4yODEgMC4wNjMtMC4zNDQgMC4xMjUtMC4wMzEgMC4wNjMtMC4wNjMgMC4xMjUtMC4wNjMgMC4yMTloMC4yNWMwLTAuMDMxIDAtMC4wNjMgMC4wMzEtMC4wOTQgMC0wLjAzMSAwLjA2My0wLjAzMSAwLjEyNS0wLjAzMWgwLjA5NHpNOS4yMTkgMTEuNzVjLTAuMDYzLTAuMDYzLTAuMDk0LTAuMTI1LTAuMDk0LTAuMjE5aDAuNjg4di0wLjE4OGMtMC4wMzEtMC4wNjMtMC4wMzEtMC4xMjUtMC4wOTQtMC4xODgtMC4wMzEtMC4wNjMtMC4wOTQtMC4xMjUtMC4xNTYtMC4xNTZzLTAuMTI1LTAuMDMxLTAuMjE5LTAuMDMxYy0wLjEyNSAwLTAuMjUgMC4wMzEtMC4zNDQgMC4xMjVzLTAuMTI1IDAuMjE5LTAuMTI1IDAuMzc1YzAgMC4xODggMC4wNjMgMC4zMTMgMC4xNTYgMC4zNzUgMC4wOTQgMC4wOTQgMC4xODggMC4xMjUgMC4zMTMgMC4xMjUgMC4xNTYgMCAwLjI4MS0wLjAzMSAwLjM3NS0wLjEyNWwwLjA5NC0wLjE4OGgtMC4yNWMtMC4wMzEgMC4wMzEtMC4wMzEgMC4wNjMtMC4wNjMgMC4wNjMtMC4wMzEgMC4wMzEtMC4wOTQgMC4wNjMtMC4xMjUgMC4wNjMtMC4wNjMgMC0wLjEyNS0wLjAzMS0wLjE1Ni0wLjAzMXpNOS44MTMgMTMuMjVjMC0wLjE1Ni0wLjAzMS0wLjI1LTAuMTI1LTAuMzc1LTAuMDYzLTAuMDk0LTAuMTg4LTAuMTI1LTAuMzQ0LTAuMTI1LTAuMTg4IDAtMC4zMTMgMC4wMzEtMC4zNzUgMC4xMjUtMC4wOTQgMC4xMjUtMC4xMjUgMC4yMTktMC4xMjUgMC4zNzUgMCAwLjEyNSAwLjAzMSAwLjI1IDAuMTI1IDAuMzQ0IDAuMDYzIDAuMDk0IDAuMTg4IDAuMTU2IDAuMzc1IDAuMTU2IDAuMTU2IDAgMC4yODEtMC4wNjMgMC4zNDQtMC4xNTYgMC4wOTQtMC4wOTQgMC4xMjUtMC4yMTkgMC4xMjUtMC4zNDR6TTguMTg4IDkuMjE5aC0wLjIxOXYxLjMxM2gwLjI1di0wLjVjMCAwLjA2MyAwLjAzMSAwLjA5NCAwLjA2MyAwLjA5NCAwLjA2MyAwLjAzMSAwLjEyNSAwLjA2MyAwLjE4OCAwLjA2MyAwLjEyNSAwIDAuMjE5LTAuMDMxIDAuMzEzLTAuMTI1IDAuMDYzLTAuMDk0IDAuMDk0LTAuMjE5IDAuMDk0LTAuMzc1cy0wLjAzMS0wLjI4MS0wLjEyNS0wLjM3NWMtMC4wNjMtMC4wNjMtMC4xNTYtMC4xMjUtMC4yODEtMC4xMjUtMC4wNjMgMC0wLjEyNSAwLjAzMS0wLjE4OCAwLjA2M2wtMC4wOTQgMC4wOTR2LTAuMTI1ek04LjQwNiAxMC42NTZoLTAuNTMxdjEuMjgxaDAuMjV2LTAuNDY5aDAuMjgxYzAuMTI1IDAgMC4yNS0wLjAzMSAwLjMxMy0wLjA5NHMwLjEyNS0wLjE1NiAwLjEyNS0wLjMxM2MwLTAuMTI1LTAuMDYzLTAuMjUtMC4xMjUtMC4zMTNzLTAuMTg4LTAuMDk0LTAuMzEzLTAuMDk0ek04LjQ2OSAxMi40Mzh2MC4yMTloMC4yNXYtMC4yMTloLTAuMjV6TTguNzE5IDEzLjcxOXYtMC45MzhoLTAuMjV2MC45MzhoMC4yNXpNOC4yNSAxMy41MzFjLTAuMDMxLTAuMDMxLTAuMDMxLTAuMDMxLTAuMDMxLTAuMDk0di0wLjQ2OWgwLjE1NnYtMC4xODhoLTAuMTU2di0wLjI4MWgtMC4yNXYwLjI4MWgtMC4xMjV2MC4xODhoMC4xMjV2MC41NjNjMCAwLjA2MyAwLjAzMSAwLjA5NCAwLjA2MyAwLjEyNSAwLjAzMSAwLjA2MyAwLjA5NCAwLjA2MyAwLjIxOSAwLjA2M2gwLjEyNXYtMC4xODhoLTAuMTI1ek03LjUzMSA5LjQwNmMwLjAzMSAwLjAzMSAwLjAzMSAwLjA2MyAwLjAzMSAwLjA5NHMwIDAuMDYzLTAuMDYzIDAuMDYzYzAgMC0wLjAzMSAwLjAzMS0wLjA5NCAwLjAzMWgtMC4wNjNjLTAuMTI1IDAuMDMxLTAuMTg4IDAuMDMxLTAuMjE5IDAuMDYzLTAuMDk0IDAuMDYzLTAuMTU2IDAuMTI1LTAuMTU2IDAuMjUgMCAwLjA5NCAwLjAzMSAwLjE1NiAwLjA5NCAwLjIxOSAwLjA2MyAwLjAzMSAwLjEyNSAwLjA2MyAwLjIxOSAwLjA2MyAwLjA2MyAwIDAuMTI1IDAgMC4xODgtMC4wMzFsMC4wOTQtMC4wOTRjMCAwIDAgMC4wMzEgMC4wMzEgMC4wNjN2MC4wMzFoMC4yODF2LTAuMDMxYy0wLjAzMSAwLTAuMDMxIDAtMC4wMzEtMC4wMzEtMC4wMzEgMC0wLjAzMS0wLjAzMS0wLjAzMS0wLjA2M3YtMC41MzFjMC0wLjEyNS0wLjAzMS0wLjE4OC0wLjEyNS0wLjI1LTAuMDYzLTAuMDMxLTAuMTU2LTAuMDYzLTAuMjgxLTAuMDYzLTAuMTU2IDAtMC4yNSAwLjA2My0wLjM0NCAwLjEyNS0wLjAzMSAwLjA2My0wLjA2MyAwLjEyNS0wLjA2MyAwLjIxOWgwLjI1YzAtMC4wMzEgMC0wLjA2MyAwLjAzMS0wLjA5NHMwLjA2My0wLjAzMSAwLjEyNS0wLjAzMWgwLjEyNXpNNy4wOTQgMTMuMjE5Yy0wLjA5NCAwLjAzMS0wLjE1NiAwLjEyNS0wLjE1NiAwLjI1IDAgMC4wOTQgMC4wMzEgMC4xNTYgMC4wOTQgMC4xODggMC4wNjMgMC4wNjMgMC4xMjUgMC4wOTQgMC4yMTkgMC4wOTQgMC4wNjMgMCAwLjEyNS0wLjAzMSAwLjE4OC0wLjA2MyAwLjAzMS0wLjAzMSAwLjA2My0wLjA2MyAwLjEyNS0wLjA5NHYwLjEyNWgwLjI4MXYtMC4wMzFsLTAuMDMxLTAuMDMxYy0wLjAzMS0wLjAzMS0wLjAzMS0wLjAzMS0wLjAzMS0wLjA2M3YtMC41NjNjMC0wLjA5NC0wLjAzMS0wLjE4OC0wLjEyNS0wLjIxOS0wLjA2My0wLjAzMS0wLjE1Ni0wLjA2My0wLjI4MS0wLjA2My0wLjE1NiAwLTAuMjUgMC4wMzEtMC4zMTMgMC4xMjUtMC4wNjMgMC4wNjMtMC4wNjMgMC4xMjUtMC4wOTQgMC4xODhoMC4yNWMwLTAuMDMxIDAuMDMxLTAuMDYzIDAuMDMxLTAuMDYzIDAuMDMxLTAuMDMxIDAuMDYzLTAuMDYzIDAuMTI1LTAuMDYzczAuMDk0IDAgMC4xMjUgMC4wMzFjMC4wMzEgMCAwLjAzMSAwLjAzMSAwLjAzMSAwLjA5NCAwIDAuMDMxIDAgMC4wMzEtMC4wMzEgMC4wNjNoLTAuMTI1bC0wLjA2MyAwLjAzMWMtMC4wOTQgMC0wLjE4OCAwLjAzMS0wLjIxOSAwLjA2M3pNNi4zMTMgOS42ODhoLTAuMjgxdjAuMDMxYzAgMC4xMjUgMC4wMzEgMC4yNSAwLjA5NCAwLjM0NHMwLjE1NiAwLjEyNSAwLjM0NCAwLjEyNWMwLjE1NiAwIDAuMjUtMC4wNjMgMC4zMTMtMC4xNTYgMC4wNjMtMC4wNjMgMC4wNjMtMC4xNTYgMC4wNjMtMC4yNXYtMC45MDZoLTAuMjV2MC45MDZjMCAwLjA2My0wLjAzMSAwLjA5NC0wLjAzMSAwLjEyNS0wLjAzMSAwLjA2My0wLjA2MyAwLjA2My0wLjEyNSAwLjA2M3MtMC4wOTQgMC0wLjA5NC0wLjA2M2MtMC4wMzEtMC4wMzEtMC4wMzEtMC4wOTQtMC4wMzEtMC4xODh2LTAuMDMxek02LjU5NCAxMi40Mzh2MC4yMTloMC4yNXYtMC4yMTloLTAuMjV6TTYuODQ0IDEzLjcxOXYtMC45MzhoLTAuMjV2MC45MzhoMC4yNXpNNS43MTkgMTIuODc1Yy0wLjA2MyAwLjA5NC0wLjEyNSAwLjIxOS0wLjEyNSAwLjM3NXMwLjA2MyAwLjI4MSAwLjEyNSAwLjM3NWMwLjA2MyAwLjA2MyAwLjE4OCAwLjEyNSAwLjM0NCAwLjEyNSAwLjEyNSAwIDAuMjUtMC4wNjMgMC4zNDQtMC4xNTYgMC4wMzEtMC4wNjMgMC4wNjMtMC4xNTYgMC4wNjMtMC4yMTloLTAuMjVjMCAwLjAzMS0wLjAzMSAwLjA5NC0wLjAzMSAwLjEyNS0wLjAzMSAwLjAzMS0wLjA2MyAwLjAzMS0wLjEyNSAwLjAzMS0wLjA5NCAwLTAuMTU2LTAuMDMxLTAuMTg4LTAuMTI1di0wLjMxM2MwLjAzMS0wLjA5NCAwLjA5NC0wLjEyNSAwLjE4OC0wLjEyNSAwLjA2MyAwIDAuMDk0IDAgMC4xMjUgMC4wMzFzMC4wMzEgMC4wNjMgMC4wMzEgMC4wOTRoMC4yNWMwLTAuMTI1LTAuMDYzLTAuMjE5LTAuMTI1LTAuMjgxLTAuMDYzLTAuMDMxLTAuMTg4LTAuMDYzLTAuMjgxLTAuMDYzLTAuMTU2IDAtMC4yNSAwLjAzMS0wLjM0NCAwLjEyNXpNNC42ODggMTIuODc1Yy0wLjA2MyAwLjEyNS0wLjEyNSAwLjIxOS0wLjEyNSAwLjM3NSAwIDAuMTI1IDAuMDYzIDAuMjUgMC4xMjUgMC4zNDQgMC4wOTQgMC4wOTQgMC4yMTkgMC4xNTYgMC4zNzUgMC4xNTZzMC4yODEtMC4wNjMgMC4zNDQtMC4xNTZjMC4wOTQtMC4wOTQgMC4xMjUtMC4yMTkgMC4xMjUtMC4zNDQgMC0wLjE1Ni0wLjAzMS0wLjI1LTAuMTI1LTAuMzc1LTAuMDYzLTAuMDk0LTAuMTg4LTAuMTI1LTAuMzQ0LTAuMTI1cy0wLjI4MSAwLjAzMS0wLjM3NSAwLjEyNXpNMi4zNDQgMTMuNDM4bDAuMDYzIDAuMjgxaDAuMzEzbC0wLjQ2OS0xLjI4MWgtMC4yODFsLTAuNDY5IDEuMjgxaDAuMjgxbDAuMDk0LTAuMjgxaDAuNDY5ek0zLjUgMTMuNjU2YzAuMDYzLTAuMDYzIDAuMDk0LTAuMTI1IDAuMDk0LTAuMjE5cy0wLjAzMS0wLjEyNS0wLjA2My0wLjE4OGMtMC4wNjMtMC4wMzEtMC4xMjUtMC4wOTQtMC4yMTktMC4wOTQtMC4xNTYtMC4wMzEtMC4yNS0wLjA2My0wLjI4MS0wLjA5NC0wLjAzMSAwLTAuMDMxLTAuMDMxLTAuMDMxLTAuMDYzIDAgMCAwLTAuMDMxIDAuMDMxLTAuMDMxIDAuMDMxLTAuMDMxIDAuMDYzLTAuMDMxIDAuMTI1LTAuMDMxczAuMDk0IDAgMC4xMjUgMC4wMzEgMC4wMzEgMC4wNjMgMC4wMzEgMC4wOTRoMC4yNWMwLTAuMTI1LTAuMDYzLTAuMTg4LTAuMTI1LTAuMjVzLTAuMTU2LTAuMDYzLTAuMjgxLTAuMDYzLTAuMjE5IDAuMDMxLTAuMzEzIDAuMDk0Yy0wLjA2MyAwLjA2My0wLjA5NCAwLjEyNS0wLjA5NCAwLjIxOSAwIDAuMDYzIDAuMDMxIDAuMTI1IDAuMDYzIDAuMTU2IDAuMDYzIDAuMDYzIDAuMTI1IDAuMDk0IDAuMjUgMC4xMjVzMC4yMTkgMC4wNjMgMC4yNSAwLjA2MyAwLjAzMSAwLjAzMSAwLjAzMSAwLjA2My0wLjAzMSAwLjA2My0wLjAzMSAwLjA2M2MtMC4wMzEgMC4wMzEtMC4wOTQgMC4wMzEtMC4xMjUgMC4wMzEtMC4wOTQgMC0wLjE1Ni0wLjAzMS0wLjE4OC0wLjA2MyAwIDAtMC4wMzEtMC4wMzEtMC4wMzEtMC4wOTRoLTAuMjVjMCAwLjA5NCAwLjAzMSAwLjE4OCAwLjEyNSAwLjI1IDAuMDYzIDAuMDYzIDAuMTU2IDAuMDk0IDAuMzEzIDAuMDk0czAuMjUtMC4wMzEgMC4zNDQtMC4wOTR6TTQuNDA2IDEzLjY1NmMwLjA2My0wLjA2MyAwLjEyNS0wLjEyNSAwLjEyNS0wLjIxOXMtMC4wMzEtMC4xMjUtMC4wOTQtMC4xODhjLTAuMDMxLTAuMDMxLTAuMTI1LTAuMDk0LTAuMjE5LTAuMDk0LTAuMTU2LTAuMDMxLTAuMjE5LTAuMDYzLTAuMjUtMC4wOTQtMC4wMzEgMC0wLjAzMS0wLjAzMS0wLjAzMS0wLjA2MyAwIDAgMC0wLjAzMSAwLjAzMS0wLjAzMSAwLjAzMS0wLjAzMSAwLjA2My0wLjAzMSAwLjA5NC0wLjAzMSAwLjA5NCAwIDAuMTI1IDAgMC4xNTYgMC4wMzEgMCAwLjAzMSAwLjAzMSAwLjA2MyAwLjAzMSAwLjA5NGgwLjI1Yy0wLjAzMS0wLjEyNS0wLjA2My0wLjE4OC0wLjEyNS0wLjI1LTAuMDk0LTAuMDYzLTAuMTg4LTAuMDYzLTAuMzEzLTAuMDYzcy0wLjIxOSAwLjAzMS0wLjI4MSAwLjA5NC0wLjA5NCAwLjEyNS0wLjA5NCAwLjIxOWMwIDAuMDYzIDAuMDMxIDAuMTI1IDAuMDYzIDAuMTU2IDAuMDMxIDAuMDYzIDAuMTI1IDAuMDk0IDAuMjE5IDAuMTI1IDAuMTU2IDAuMDMxIDAuMjUgMC4wNjMgMC4yNSAwLjA2MyAwLjAzMSAwIDAuMDYzIDAuMDMxIDAuMDYzIDAuMDYzcy0wLjAzMSAwLjA2My0wLjA2MyAwLjA2M2MtMC4wMzEgMC4wMzEtMC4wNjMgMC4wMzEtMC4xMjUgMC4wMzFzLTAuMTI1LTAuMDMxLTAuMTU2LTAuMDYzYy0wLjAzMSAwLTAuMDMxLTAuMDMxLTAuMDMxLTAuMDk0aC0wLjI1YzAgMC4wOTQgMC4wMzEgMC4xODggMC4wOTQgMC4yNSAwLjA5NCAwLjA2MyAwLjE4OCAwLjA5NCAwLjM0NCAwLjA5NHMwLjI1LTAuMDMxIDAuMzEzLTAuMDk0ek0xMy4yODEgMjYuMzc1aDM0LjI4MXYtOS4zNzVjMC00LjE4OC0zLjkwNi03LjU2My04Ljc1LTcuNTYzaC0yNi44NDRjMC4xMjUgMC40MDYgMC4xODggMC44NDQgMC4xODggMS4zMTMgMCAzLTIuNzE5IDUuNDY5LTYuMDk0IDUuNDY5LTAuNTMxIDAtMS4wMzEtMC4wNjMtMS41MzEtMC4xODh2Mi44MTNjMCA0LjE1NiAzLjkzOCA3LjUzMSA4Ljc1IDcuNTMxek05LjM0NCA5Ljc1aDAuMDYzYzAuMDMxIDAgMC4wNjMtMC4wMzEgMC4wNjMtMC4wMzFoMC4wNjN2MC4wNjNjMCAwLjA5NC0wLjAzMSAwLjE1Ni0wLjA5NCAwLjE4OC0wLjAzMSAwLjAzMS0wLjA5NCAwLjAzMS0wLjEyNSAwLjAzMWgtMC4wOTRjLTAuMDMxLTAuMDMxLTAuMDMxLTAuMDYzLTAuMDMxLTAuMDk0IDAtMC4wNjMgMC0wLjA5NCAwLjA2My0wLjEyNSAwIDAgMC4wNjMtMC4wMzEgMC4wOTQtMC4wMzF6TTM2LjAzMSAxMC43NWgyLjE1NmM0LjM0NCAwIDcuODQ0IDIuOTA2IDcuODQ0IDYuNDY5djcuOTM4aC0ydi03LjYyNWMwLTIuNjg4LTIuODQ0LTQuODc1LTYuMzEzLTQuODc1aC0xLjY4OHY1LjE4OGg2djJoLTZ2NS4zMTNoLTJ2LTE0LjQwNmgyek0xNC4zNDQgMjMuMjVoMS43MTl2LTEyLjVoMnYxNC40MDZoLTQuMTg4Yy00LjMxMyAwLTcuODQ0LTIuOTA2LTcuODQ0LTYuNXYtMC42ODhoMi4wOTR2MC41MzFjMCAyLjYyNSAyLjc4MSA0Ljc1IDYuMjE5IDQuNzV6TTIyIDEwLjc1aDQuNWMxLjc4MSAwIDMuMzQ0IDAuNzgxIDQuNDA2IDIgMC43ODEgMC45MzggMS4yODEgMi4xMjUgMS4yODEgMy40MzhzLTAuNSAyLjUtMS4yODEgMy40MzhjLTEuMDYzIDEuMjE5LTIuNjI1IDItNC40MDYgMmgtMi41di0yaDIuNzVjMS44MTMtMC4xODggMy4yMTktMS42NTYgMy4yMTktMy40MzhzLTEuNDA2LTMuMjUtMy4yMTktMy40MzhoLTQuNzV2MTIuNDA2aC0ydi0xNC40MDZoMnoiPjwvcGF0aD4NCjwvc3ZnPg==) <img src="https://img.shields.io/badge/Spring Security-6DB33F?style=flat&logo=Spring Security&logoColor=white"/> <img src="https://img.shields.io/badge/Gradle-02303A?style=flat&logo=Gradle&logoColor=white"/> <img src="https://img.shields.io/badge/MySQL-4479A1?style=flat&logo=MySQL&logoColor=white"/> <img src="https://img.shields.io/badge/Redis-DC382D?style=flat&logo=Redis&logoColor=white"/>

:yellow_heart: **AI**
<img src="https://img.shields.io/badge/Python-3776AB?style=flat&logo=Python&logoColor=white"/>
<img src="https://img.shields.io/badge/NumPy-013243?style=flat&logo=NumPy&logoColor=white"/>
<img src="https://img.shields.io/badge/pandas-150458?style=flat&logo=pandas&logoColor=white"/>
<img src="https://img.shields.io/badge/PyTorch-EE4C2C?style=flat&logo=PyTorch&logoColor=white"/>
<img src="https://img.shields.io/badge/OpenAI-412991?style=flat&logo=OpenAI&logoColor=white"/>
<img src="https://img.shields.io/badge/Jupyter-F37626?style=flat&logo=Jupyter&logoColor=white"/>
<img src="https://img.shields.io/badge/Google Colab-F9AB00?style=flat&logo=Google Colab&logoColor=white"/>
<img src="https://img.shields.io/badge/Django-092E20?style=flat&logo=Django&logoColor=white"/>

:green_heart: **CI/CD**
<img src="https://img.shields.io/badge/Linux-FCC624?style=flat&logo=Linux&logoColor=white"/> <img src="https://img.shields.io/badge/Docker-2496ED?style=flat&logo=Docker&logoColor=white"/> <img src="https://img.shields.io/badge/Jenkins-D24939?style=flat&logo=Jenkins&logoColor=white"/> <img src="https://img.shields.io/badge/Amazon EC2-FF9900?style=flat&logo=Amazon EC2&logoColor=white"/>

:purple_heart: **Tools**
<img src="https://img.shields.io/badge/Git-F05032?style=flat&logo=Git&logoColor=white"/> <img src="https://img.shields.io/badge/GitLab-FC6D26?style=flat&logo=GitLab&logoColor=white"/> <img src="https://img.shields.io/badge/Postman-FF6C37?style=flat&logo=Postman&logoColor=white"/> <img src="https://img.shields.io/badge/Jira-0052CC?style=flat&logo=Jira Software&logoColor=white"/> <img src="https://img.shields.io/badge/Notion-000000?style=flat&logo=Notion&logoColor=white"/> <img src="https://img.shields.io/badge/Mattermost-0058CC?style=flat&logo=Mattermost&logoColor=white"/> <img src="https://img.shields.io/badge/Discord-5865F2?style=flat&logo=Discord&logoColor=white"/>

:sparkling_heart: **IDE**
<img src="https://img.shields.io/badge/VS Code-007ACC?style=flat&logo=Visual Studio Code&logoColor=white"/> 
<img src="https://img.shields.io/badge/IntelliJ-000000?style=flat&logo=IntelliJ IDEA&logoColor=white"/>

<br />

### 🚀 배포 주소

    🔎 URL : [https://j8b101.p.ssafy.io/]

<br />

### 🎫 ERD

#### ![ERD](https://user-images.githubusercontent.com/109534450/229389722-3c06c51e-9822-40cd-ba7b-cb1b60aaa1da.png)
<br />

### 🍏 API

#### ![api](https://user-images.githubusercontent.com/109534450/229389453-80caf23c-fae6-403b-b71d-301f4495feb7.PNG)
- [Postman API 정리](https://documenter.getpostman.com/view/25310566/2s93JxsMqe)

<br />

### 🎇 서비스 아키텍쳐


<br />

## 📜 프로젝트 결과물


### 약관 동의

<br />

### 메인 페이지

<br />

### 다이어리 작성 페이지

<br />

### 월 / 일

<br />

### 시각화

<br />

### 프로그램 설정

<br />



## 🎨 FE

Flutter STT
  Flutter의 STT(Speech To Text) 패키지는 음성인식 API를 사용합니다.

모바일 운영체제(Android, iOS)에 따라서 사용하는 API가 다릅니다.

- **Android** : Google Speech Recognition API
- **iOS** : Siri Speech Recognition API

기존의 STT는 머신러닝이나 딥 러닝 모델을 사용하여 학습하고 모델을 구축하지만,

Flutter의 STT 패키지는 플랫폼별 API를 사용하여 음성 인식 작업을 수행합니다 (대규모 데이터셋에서 사전 훈련되며 음성 및 언어 모델의 조합을 사용하여 음성인식을 수행)

**성능** : 일반적은 대화에서는 좋은 성능과 정확도를 제공하지만,

특정 사용 사례나 언어에 최적화되어 있지 않습니다. ex) 싸피


# 🗿 AI 🩺 사용 모델 : KoBERT / KoGPT2
---

## 🛹 KoBERT ?

- Bert 모델의 한국어 버전으로, SKT에서  구글의 BERT 모델을 바탕으로 개발하였습니다. 

- 자연어 처리(NLP)가 가능한 사전 학습된 언어 모델입니다.

- 한국어 문장 분류, 개체명 인식, 문장 유사도를 파악할 수 있습니다.

- 네이버에서 공개한 한글 위키피디아 데이터를 사전 학습하였습니다.

- [KoBERT 깃허브](https://github.com/SKTBrain/KoBERT)

--- 
## 🛶 BERT?
- BERT는 "Bidirectional Encoder Representations from Transformers"의 약어로, 구글에서 개발한 사전 학습된 언어 모델입니다. 
- BERT의 장점인 사전 학습된 언어 모델의 지식을 활용하여 문장 분류, 문장 유사도, 질문 응답 등의 자연어 처리 태스크를 수행합니다.
- 적은 양의 데이터로도 높은 성능을 발휘할 수 있는 장점이 있습니다.

- Transformer라는 모델 구조를 사용합니다. 
    * Transformer는 Attention mechanism을 사용하여 입력된 단어들 사이의 의존 관계를 찾아내는 모델입니다.
- [BERT 깃허브](https://github.com/google-research/bert)

---

## 🛫 KoGPT2 ?

- KoGPT2는 SKT에서 개발한 한국어 자연어 처리를 위한 GPT 모델입니다. GPT는 Generative Pre-trained Transformer의 약자로, 트랜스포머(Transformer) 모델을 이용하여 텍스트 생성에 대한 학습을 수행합니다.

- KoGPT2는 한국어 문장에 대한 토큰화(tokenization), 임베딩(embedding), GPT 모델 학습 및 텍스트 생성을 수행할 수 있는 모듈들을 제공합니다. 이를 이용하여 다양한 한국어 자연어 처리 태스크에 활용할 수 있습니다. 
- KoGPT2를 이용하여 자연어 처리 태스크를 수행하려면, 먼저 문장을 토큰화하고 KoGPT 모델에 입력으로 넣어 예측값을 얻을 수 있습니다. 이후, 얻은 예측값을 이용하여 다양한 자연어 처리 태스크를 수행할 수 있습니다.

---
## 💡 **감정 분석 👉 KoBERT**

### ✏️ **Process**

1. **입력 데이터 전 처리**
    - 입력 문장을 토큰화하여 토큰 ID로 변환합니다.
    문장의 실제 길이를 나타내는 마스크를 생성합니다.
    문장 쌍의 경우, 문장 간 구분을 나타내는 세그먼트 ID를 생성합니다.
2. **BERT 모델 적용**
    - 전처리된 입력 데이터를 BERT 모델에 입력하여 출력값을 얻습니다.
    - BERT 모델은 입력 토큰을 임베딩하고, 어텐션 메커니즘을 사용하여 각 토큰의 의미를 파악합니다.
    - 출력값은 BERT의 출력 차원 크기인 768차원으로 나옵니다.
3. **출력값 변환**
    - BERT 모델의 출력값 중 문장을 대표하는 pooler를 사용하여 768차원 벡터를 얻습니다.
    - 벡터를 선형 레이어를 사용하여 클래스 레이블에 대한 로짓으로 변환합니다.
    - 로짓은 각 클래스에 대한 점수를 의미합니다.
4. **손실 함수 및 최적화**
    - logit과 실제 클래스 레이블 간의 차이를 측정하는 교차 엔트로피 손실 함수를 사용하여 학습합니다.
    - 학습에는 확률적 경사 하강법(Stochastic Gradient Descent)의 변형 중 하나인 AdamW 옵티마이저를 사용합니다.
    - 학습률과 학습 스케줄링 등을 조정하여 학습을 진행합니다.

### 🧾 Dataset
- [AI Hub 감성 대화 말뭉치 데이터 셋](https://aihub.or.kr/aihubdata/data/view.do?currMenu=115&topMenu=100&aihubDataSe=realm&dataSetSn=86)
- 추가 데이터 생성 및 학습

### 🛠 Requirements

```
!pip install gluonnlp pandas tqdm
!pip install mxnet
!pip install sentencepiece
!pip install transformers
!pip install torch
!pip install 'git+https://github.com/SKTBrain/KoBERT.git#egg=kobert_tokenizer&subdirectory=kobert_hf'

```

### ⚾️ Import

```
import torch
from torch import nn
import torch.nn.functional as F
import torch.optim as optim
from torch.utils.data import Dataset, DataLoader
import gluonnlp as nlp
import numpy as np
from tqdm import tqdm, tqdm_notebook
import pandas as pd
from sklearn.model_selection import train_test_split
from kobert_tokenizer import KoBERTTokenizer
from transformers import BertModel
from transformers import AdamW
from transformers.optimization import get_cosine_schedule_with_warmup

from google.colab import drive
drive.mount('/content/drive')

```

- **torch**
- **nn, optim, F, Dataset, DataLoader :** 파이토치 라이브러리의 하위 모듈, 신경망 모델, 최적화 알고리즘, 함수, 데이터셋 및 데이터 로더
- **gluonnlp :** MXNet 프레임 워크에서 사용되는 자연어 처리 라이브러리
- **numpy :** 다차원 행렬 관련
- **pandas :** 데이터 처리
- **KoBERTTokenizer :** KoBERT의 토크나이저
- **BertModel**
- **AdamW :** AdamW 최적화
- **get_cosine_schedule_with_warmup :** learning rate 스케줄링 적용 함수
- **drive.mount('/content/drive/') :** 구글 드라이브를 Colab에 동기화
- **device = torch.device("cuda:0") :** GPU 사용

### 🎾 Hyper Parameter

```
# Setting parameters
max_len = 64
batch_size = 64
warmup_ratio = 0.1
num_epochs = 50
max_grad_norm = 1
log_interval = 200
learning_rate =  5e-5
```

***하이퍼 파라미터 셋팅***

- **max_len** 문장 최대 길이
- **batch_size** 한 번의 batch마다 주는 데이터 샘플의 size. 
- **num_epochs :** 전체 학습 데이터 학습 횟수
- **learning_rate :** 학습률

### 🧚‍♀️ BERT Dataset

```
class BERTDataset(Dataset):
    def __init__(self, dataset, sent_idx, label_idx, bert_tokenizer,vocab, max_len,
                 pad, pair):

        transform = nlp.data.BERTSentenceTransform(
            bert_tokenizer, max_seq_length=max_len,vocab=vocab, pad=pad, pair=pair)

        self.sentences = [transform([i[sent_idx]]) for i in dataset]
        self.labels = [np.int32(i[label_idx]) for i in dataset]

    def __getitem__(self, i):
        return (self.sentences[i] + (self.labels[i], ))

    def __len__(self):
        return (len(self.labels))
```

- gluonnlp의 BERTSentenceTransform을 사용하여 입력 문장을 BERT 입력 형식에 맞게 변환합니다.
-transform 메서드를 사용하여 각 문장을 BERT 입력 형식에 맞게 변환

### 🧚‍♂️ BERT Classifier

```
class BERTClassifier(nn.Module):
    def __init__(self,
                 bert,
                 hidden_size = 768,
                 num_classes=6,
                 dr_rate=None,
                 params=None):
        super(BERTClassifier, self).__init__()
        self.bert = bert
        self.dr_rate = dr_rate

        self.classifier = nn.Linear(hidden_size , num_classes)
        if dr_rate:
            self.dropout = nn.Dropout(p=dr_rate)

    def gen_attention_mask(self, token_ids, valid_length):
        attention_mask = torch.zeros_like(token_ids)
        for i, v in enumerate(valid_length):
            attention_mask[i][:v] = 1
        return attention_mask.float()

    def forward(self, token_ids, valid_length, segment_ids):
        attention_mask = self.gen_attention_mask(token_ids, valid_length)

        _, pooler = self.bert(input_ids = token_ids, token_type_ids = segment_ids.long(), attention_mask = attention_mask.float().to(token_ids.device))
        if self.dr_rate:
            out = self.dropout(pooler)
        return self.classifier(out)

```

- 입력 데이터의 패딩 부분을 제외하고, 실제 입력에 대한 어텐션 마스크를 생성하는 함수입니다.
- token_ids는 입력 문장을 토큰화한 결과
- gen_attention_mask 메서드를 사용하여 어텐션 마스크를 생성
- BERT 모델에 입력을 전달하여 출력을 계산합니다.

### 🔫 토크 나이저 / 모델 정의

```
tokenizer = KoBERTTokenizer.from_pretrained('skt/kobert-base-v1')
bertmodel = BertModel.from_pretrained('skt/kobert-base-v1', return_dict=False)
vocab = nlp.vocab.BERTVocab.from_sentencepiece(tokenizer.vocab_file, padding_token='[PAD]')
tok = tokenizer.tokenize
```

- skt/kobert-base-v1 모델의 **사전 학습된 가중치** 로드
- BERTVocab 객체에 tokenizer.vocab_file 사전(vocab) 로드

### 💿 데이터 로드/ 전처리

```
train_set = pd.read_csv('/content/drive/MyDrive/Colab Notebooks/감정분석dataset.csv', encoding='cp949')
validation_set = pd.read_csv('/content/drive/MyDrive/Colab Notebooks/감성대화말뭉치(최종데이터)_Validation.csv',encoding='cp949')
train_set = train_set.loc[:, ['sentiment', 'user']]
validation_set = validation_set.loc[:, ['감정_대분류', '사람문장1']]

train_set.dropna(inplace=True)
validation_set.dropna(inplace=True)
train_set.columns = ['label', 'data']
validation_set.columns = ['label', 'data']

train_set.loc[(train_set['label'] == '일상'), 'label'] = 0
train_set.loc[(train_set['label'] == '분노'), 'label'] = 1
train_set.loc[(train_set['label'] == '불안'), 'label'] = 2
train_set.loc[(train_set['label'] == '슬픔'), 'label'] = 3
train_set.loc[(train_set['label'] == '기쁨'), 'label'] = 4
train_set.loc[(train_set['label'] == '우울'), 'label'] = 5

validation_set.loc[(validation_set['label'] == '일상'), 'label'] = 0
validation_set.loc[(validation_set['label'] == '분노'), 'label'] = 1
validation_set.loc[(validation_set['label'] == '불안'), 'label'] = 2
validation_set.loc[(validation_set['label'] == '슬픔'), 'label'] = 3
validation_set.loc[(validation_set['label'] == '기쁨'), 'label'] = 4
validation_set.loc[(validation_set['label'] == '우울'), 'label'] = 5

train_set_data = [[i, str(j)] for i, j in zip(train_set['data'], train_set['label'])]

# validation_set_data = [[i, str(j)] for i, j in zip(validation_set['data'], validation_set['label'])]

train_set_data, test_set_data = train_test_split(train_set_data, test_size = 0.2, random_state=4)
train_set_data = BERTDataset(train_set_data, 0, 1, tok, vocab, max_len, True, False)
test_set_data = BERTDataset(test_set_data, 0, 1, tok, vocab, max_len, True, False)
train_dataloader = torch.utils.data.DataLoader(train_set_data, batch_size=batch_size, num_workers=2)
test_dataloader = torch.utils.data.DataLoader(test_set_data, batch_size=batch_size, num_workers=2)

```

### 🧸 모델 학습

```
model = BERTClassifier(bertmodel, dr_rate=0.5).to(device)
# Prepare optimizer and schedule (linear warmup and decay)
no_decay = ['bias', 'LayerNorm.weight']
optimizer_grouped_parameters = [
    {'params': [p for n, p in model.named_parameters() if not any(nd in n for nd in no_decay)], 'weight_decay': 0.01},
    {'params': [p for n, p in model.named_parameters() if any(nd in n for nd in no_decay)], 'weight_decay': 0.0}
]
optimizer = AdamW(optimizer_grouped_parameters, lr=learning_rate)
loss_fn = nn.CrossEntropyLoss()
t_total = len(train_dataloader) * num_epochs
warmup_step = int(t_total * warmup_ratio)
scheduler = get_cosine_schedule_with_warmup(optimizer, num_warmup_steps=warmup_step, num_training_steps=t_total)

for e in range(num_epochs):
    train_acc = 0.0
    test_acc = 0.0
    model.train()
    for batch_id, (token_ids, valid_length, segment_ids, label) in enumerate(tqdm_notebook(train_dataloader)):
        optimizer.zero_grad()
        token_ids = token_ids.long().to(device)
        segment_ids = segment_ids.long().to(device)
        valid_length= valid_length
        label = label.long().to(device)
        out = model(token_ids, valid_length, segment_ids)
        loss = loss_fn(out, label)
        loss.backward()
        torch.nn.utils.clip_grad_norm_(model.parameters(), max_grad_norm)
        optimizer.step()
        scheduler.step()  # Update learning rate schedule
        train_acc += calc_accuracy(out, label)
        if batch_id % log_interval == 0:
            print("epoch {} batch id {} loss {} train acc {}".format(e+1, batch_id+1, loss.data.cpu().numpy(), train_acc / (batch_id+1)))
    print("epoch {} train acc {}".format(e+1, train_acc / (batch_id+1)))
    model.eval()
    for batch_id, (token_ids, valid_length, segment_ids, label) in enumerate(tqdm_notebook(test_dataloader)):
        token_ids = token_ids.long().to(device)
        segment_ids = segment_ids.long().to(device)
        valid_length= valid_length
        label = label.long().to(device)
        out = model(token_ids, valid_length, segment_ids)
        test_acc += calc_accuracy(out, label)
    print("epoch {} test acc {}".format(e+1, test_acc / (batch_id+1)))

```

**train 과 validation 진행**

### **학습 설정값**

- BERTClassifier 클래스를 사용하여 모델 객체를 생성합니다.
- 모델은 BERT 모델과 클래스 분류를 위한 선형 레이어로 구성
- AdamW 옵티마이저를 사용하여 학습을 진행합니다.
- 가중치 감쇠(weight decay)를 적용하여 과적합을 방지합니다.
- 가중치 감쇠를 적용하지 않는 파라미터와 적용하는 파라미터를 구분하여 옵티마이저를 설정
- CrossEntropyLoss 함수를 사용하여 손실값을 계산합니다.

### **학습 동작과정 (for ~)**

- 모델을 학습 모드로 변경합니다.
- token_ids, segment_ids, valid_length, label 값을 GPU 올리고, model에 input -> out
- out 값과 label 값을 사용하여 Cross Entropy Loss를 계산합니다.
- loss.backward() 함수를 호출해 모델의 각 파라미터에 대한 그래디언트를 계산
- optimizer.step() 함수를 호출하여 그래디언트 값을 사용하여 파라미터를 업데이트
- CosineAnnealingWarmRestarts 스케줄러 사용, 학습률을 조정
- 현재 배치의 학습 정확도 train_acc에 누적
- 현재 epoch의 학습 정확도를 출력

### **🧬 감정**
**😀일상 - 0 😊기쁨 -1 😧불안 - 2 😭슬픔 - 3 😡분노 - 4 😥우울 - 5**

<img src = "https://user-images.githubusercontent.com/109534450/229018209-f9fb7af0-0800-47f8-981b-3ea3e13d2e9d.png" width="55%" height="55%">


### 📤 Predict

```
def calc_accuracy(X,Y):
    max_vals, max_indices = torch.max(X, 1)
    train_acc = (max_indices == Y).sum().data.cpu().numpy()/max_indices.size()[0]
    return train_acc
def predict(sentence):
    dataset = [[sentence, '0']]
    test = BERTDataset(dataset, 0, 1, tok, vocab, max_len, True, False)
    test_dataloader = torch.utils.data.DataLoader(test, batch_size=batch_size, num_workers=2)
    model.eval()
    answer = 0
    for batch_id, (token_ids, valid_length, segment_ids, label) in enumerate(test_dataloader):
        token_ids = token_ids.long().to(device)
        segment_ids = segment_ids.long().to(device)
        valid_length= valid_length
        label = label.long().to(device)
        out = model(token_ids, valid_length, segment_ids)
        for logits in out:
            logits = logits.detach().cpu().numpy()
            answer = np.argmax(logits)
    return answer
```

- predict 함수는 입력 문장을 입력 받아 해당 문장 감정 예측하는 함수
- 입력 문장을 dataset에 추가하여 BERTDataset 객체를 생성
- 모델 평가 모드(model.eval())
- DataLoader에서 배치 단위로 입력 데이터를 가져와 모델에 입력하여 예측 값을 얻습니다.
- 모델 출력 값에서 가장 큰 값에 해당하는 인덱스를 예측 값으로 반환

### 📩 **OUT**
<img src = "https://user-images.githubusercontent.com/109534450/229065068-57d1e4f1-b9f1-461c-a0d2-d8a1d966d20f.png" width="55%" height="55%">

### ✨ 결과물
**Loss**
- CrossEntropyLoss() - 교차 엔트로피 오차
- <img src = "https://user-images.githubusercontent.com/109534450/229016538-98df19eb-1bd3-4f78-8aff-abf498ca8759.png" width="35%" height="35%">
- 두 확률 분포의 차이를 구하기 위해서 사용됩니다.
- 실제 데이터의 확률 분포와, 학습된 모델이 계산한 확률 분포의 차이를 구하는데 사용된다.

<img src = "https://user-images.githubusercontent.com/109534450/229390889-8b9a2114-675f-4529-aacf-29a2fbd19055.png" width="55%" height="55%">



**Accuracy**


<img src = "https://user-images.githubusercontent.com/109534450/229020020-d61be612-8721-4348-9961-390a18955766.png" width="55%" height="55%">

---
## 💡 **감성 챗봇 👉 KoGPT2**
### ✏️ **Process**

1. 데이터 전처리

- 대화 문장을 토큰화하여 토큰 ID로 변환합니다.
질문과 대답 간 구분을 나타내는 토큰을 추가합니다.
문장 쌍의 경우, 문장 간 구분을 나타내는 토큰을 추가합니다.
문장의 길이가 최대 길이를 초과하는 경우, 최대 길이에 맞게 잘라냅니다.
2. koGPT 모델 적용

- 전처리된 입력 데이터를 KoGPT2 모델에 입력하여 출력값을 얻습니다.
KoGPT2 모델은 입력 토큰을 임베딩하고, 어텐션 메커니즘을 사용하여 각 토큰의 의미를 파악합니다.
출력값은 KoGPT2 모델의 출력 차원 크기와 동일한 크기의 로짓으로 나옵니다.
3. 손실 함수 및 최적화

- logit과 실제 레이블 간의 차이를 측정하는 교차 엔트로피 손실 함수를 사용하여 학습합니다.
학습에는 Adam 옵티마이저를 사용합니다.
학습률과 학습 스케줄링 등을 조정하여 학습을 진행합니다.
4. Predict

- KoGPT2 모델을 활용하여 입력된 질문에 대한 대답을 생성합니다.
인코딩된 input_ids를 모델에 입력으로 넣어 예측 결과를 생성합니다.
예측 결과에서 가장 확률이 높은 토큰을 선택하여 대답을 생성합니다.

### 🧾 **Dataset**

- [감성 대화 말뭉치 데이터 셋 (AI Hub)](https://aihub.or.kr/aihubdata/data/view.do?currMenu=115&topMenu=100&aihubDataSe=realm&dataSetSn=86)
- 추가 데이터 생성 및 학습

### 🛠 **Requirements**
```
! pip install transformers
! pip install pytorch-lightning
! pip install torch
```

### ⚾️ **Import**

```
import numpy as np
import pandas as pd
import torch
from pytorch_lightning import Trainer
from pytorch_lightning.callbacks import ModelCheckpoint
from pytorch_lightning import LightningModule
from torch.utils.data import DataLoader, Dataset
from transformers.optimization import AdamW, get_cosine_schedule_with_warmup
from transformers import PreTrainedTokenizerFast, GPT2LMHeadModel
import re

```
### **🥌 토큰**
```python
Q_TKN = "<usr>"
A_TKN = "<sys>"
BOS = '</s>'
EOS = '</s>'
MASK = '<unused0>'
SENT = '<unused1>'
PAD = '<pad>
```
- Q_TKN = "<usr>" : 질문 유저 토큰
- A_TKN = "<sys>" : 대답 시스템 토큰
- BOS = '</s>' : 문장의 시작
- EOS = '</s>' : 문장의 끝을
- MASK = '<unused0>' : 마스크 처리
- SENT = '<unused1>' : 문장 처리
- PAD = '<pad>' : 패딩 

### 🎾 **Hyper Parameter**

```
# Setting parameters
learning_rate = 3e-5
criterion = torch.nn.CrossEntropyLoss(reduction="mean")
optimizer = torch.optim.Adam(model.parameters(), lr=learning_rate)
epoch = 70
Sneg = -1e18
```

***하이퍼 파라미터 셋팅***
- criterion :  CrossEntropyLoss 
- optimizer : Adam 

### 🧚‍♀️ **KoGPT2 Chatbot Dataset**

```python 
class ChatbotDataset(Dataset):
    def __init__(self, chats, max_len=100):  # 데이터셋의 전처리를 해주는 부분
        self._data = chats
        self.max_len = max_len
        self.q_token = Q_TKN
        self.a_token = A_TKN
        self.sent_token = SENT
        self.eos = EOS
        self.mask = MASK
        self.tokenizer = koGPT2_TOKENIZER

    def __len__(self):  # chatbotdata 의 길이를 리턴한다.
        return len(self._data)

    def __getitem__(self, idx):  # 로드한 챗봇 데이터를 차례차례 DataLoader로 넘겨주는 메서드
        turn = self._data.iloc[idx]
        q = turn["사람문장1"]  # 질문을 가져온다.
        q = re.sub(r"([?.!,])", r" ", q)  # 구둣점들을 제거한다.

        a = turn["시스템문장1"]  # 답변을 가져온다.
        a = re.sub(r"([?.!,])", r" ", a)  # 구둣점들을 제거한다.

        q_toked = self.tokenizer.tokenize(self.q_token + q + self.sent_token)
        q_len = len(q_toked)

        a_toked = self.tokenizer.tokenize(self.a_token + a + self.eos)
        a_len = len(a_toked)

        #질문의 길이가 최대길이보다 크면
        if q_len > self.max_len:
            a_len = self.max_len - q_len        #답변의 길이를 최대길이 - 질문길이
            if a_len <= 0:       #질문의 길이가 너무 길어 질문만으로 최대 길이를 초과 한다면
                q_toked = q_toked[-(int(self.max_len / 2)) :]   #질문길이를 최대길이의 반으로 
                q_len = len(q_toked)
                a_len = self.max_len - q_len              #답변의 길이를 최대길이 - 질문길이
            a_toked = a_toked[:a_len]
            a_len = len(a_toked)

        #질문의 길이 + 답변의 길이가 최대길이보다 크면
        if q_len + a_len > self.max_len:
            a_len = self.max_len - q_len        #답변의 길이를 최대길이 - 질문길이
            if a_len <= 0:       #질문의 길이가 너무 길어 질문만으로 최대 길이를 초과 한다면
                q_toked = q_toked[-(int(self.max_len / 2)) :]   #질문길이를 최대길이의 반으로 
                q_len = len(q_toked)
                a_len = self.max_len - q_len              #답변의 길이를 최대길이 - 질문길이
            a_toked = a_toked[:a_len]
            a_len = len(a_toked)

        # 답변 labels = [mask, mask, ...., mask, ..., <bos>,..답변.. <eos>, <pad>....]
        labels = [self.mask,] * q_len + a_toked[1:]

        # mask = 질문길이 0 + 답변길이 1 + 나머지 0
        mask = [0] * q_len + [1] * a_len + [0] * (self.max_len - q_len - a_len)
        # 답변 labels을 index 로 만든다.
        labels_ids = self.tokenizer.convert_tokens_to_ids(labels)
        # 최대길이만큼 PADDING
        while len(labels_ids) < self.max_len:
            labels_ids += [self.tokenizer.pad_token_id]

        # 질문 + 답변을 index 로 만든다.    
        token_ids = self.tokenizer.convert_tokens_to_ids(q_toked + a_toked)
        # 최대길이만큼 PADDING
        while len(token_ids) < self.max_len:
            token_ids += [self.tokenizer.pad_token_id]

        #질문+답변, 마스크, 답변
        return (token_ids, np.array(mask), labels_ids)

def collate_batch(batch):
    data = [item[0] for item in batch]
    mask = [item[1] for item in batch]
    label = [item[2] for item in batch]
    return torch.LongTensor(data), torch.LongTensor(mask), torch.LongTensor(label)
```


### 🔫 **토크 나이저 / 모델 정의**

```python
koGPT2_TOKENIZER = PreTrainedTokenizerFast.from_pretrained("skt/kogpt2-base-v2",
            bos_token=BOS, eos_token=EOS, unk_token='<unk>',
            pad_token=PAD, mask_token=MASK) 
model = GPT2LMHeadModel.from_pretrained('skt/kogpt2-base-v2')
```

- skt/kogpt2-base-v2 모델에 대한 토크나이저 로드
- GPT2LMHeadModel은 GPT-2 모델 로드, 'skt/kogpt2-base-v2' 모델

### 💿 **데이터 로드/ 전처리**

```python
import urllib.request

Chatbot_Data = pd.read_csv("./data/감성대화말뭉치(최종데이터)_Training.csv", encoding="cp949")
Chatbot_Data = Chatbot_Data[:51629]
Chatbot_Data.head()
train_set = ChatbotDataset(Chatbot_Data, max_len=100)
train_dataloader = DataLoader(train_set, batch_size=32, num_workers=0, shuffle=True, collate_fn=collate_batch,)
```

### 🧸 **모델 학습**

```python
import matplotlib.pyplot as plt

losses = []
X = []
Y = []
print("start")
for epoch in range(epoch):
    print(epoch)
    X.append(epoch)
    for batch_idx, samples in enumerate(train_dataloader):
        optimizer.zero_grad()
        token_ids, mask, label = samples
        token_ids = token_ids.to(device)
        mask = mask.to(device)
        label = label.to(device)
        out = model(token_ids)        
        out = out.logits.to(device)
        
        mask_3d = mask.unsqueeze(dim=2).repeat_interleave(repeats=out.shape[2], dim=2).to(device)
        mask_out = torch.where(mask_3d == 1, out, Sneg * torch.ones_like(out)).to(device)
        loss = criterion(mask_out.transpose(2, 1), label).to(device)
        
        avg_loss = loss.sum() / mask.sum()
        avg_loss.backward()
        optimizer.step()
    Y.append(loss.data.cpu().numpy())
print("end")

```
- train_dataloader에서 token_ids, mask, label 값을 할당

- optimizer를 초기화하고, 모델의 출력 값 out을 계산, logits 메서드를 이용하여 로짓 값을 계산

- mask 값을 3차원으로 확장, out과 동일한 크기로 반복하여 mask_3d를 생성.
- torch.where 메서드를 이용하여 mask가 1인 위치는 out 값을, 0인 위치는 Negative infinity 값을 가지는 텐서를 생성하여 mask_out 변수에 할당

- 손실 함수(criterion)를 계산하고, loss 값을 이용하여 현재 손실 값을 구합니다. 이때, 손실 값의 평균을 구하기 위해 avg_loss 변수를 계산

- backward 메서드를 이용하여 그라디언트를 계산하고, step 메서드를 이용하여 파라미터를 업데이트

### 📤 **Predict**

```python
def kogpt(input_text):
    q = input_text
    a = ""
    sent = ""
    while True:
        input_ids = torch.LongTensor(koGPT2_TOKENIZER.encode(Q_TKN + q + SENT + sent + A_TKN + a)).unsqueeze(dim=0)
        pred = model(input_ids)
        pred = pred.logits
        gen = koGPT2_TOKENIZER.convert_ids_to_tokens(torch.argmax(pred, dim=-1).squeeze().tolist())[-1]
        if gen == EOS:
            break
        a += gen.replace("▁", " ")
    return a
```

-  koGPT2 모델을 활용하여 입력된 질문에 대한 대답을 생성하는 함수
- 인코딩된 input_ids를 모델에 입력으로 넣어 pred 변수에 예측 결과를 저장
- torch.argmax 함수를 이용하여 가장 확률이 높은 토큰을 선택하고, 이를 gen 변수에 저장, 이때 convert_ids_to_tokens 함수를 이용하여 선택된 토큰을 문자열로 변환

- gen 변수가 EOS인 경우, 생성 과정을 마침. 그렇지 않은 경우 gen에 대한 값을 a에 추가

### 📩 **OUT**

```
input_text = "오늘 갑자기 날씨가 추워져서 놀랐어"
kogpt(sentence) # "날씨가 많이 추워졌군요"
```



## 💡 **감성 챗봇 👉 KoBERT**



### **데이터 셋**
- AI Hub 제공, 웰니스 대화 스크립트 데이터셋 (_현재 페이지 없음_)

### ✨ 결과물
**Loss**
- CrossEntropyLoss() - 교차 엔트로피 오차
- <img src = "https://user-images.githubusercontent.com/109534450/229016538-98df19eb-1bd3-4f78-8aff-abf498ca8759.png" width="35%" height="35%">
- 두 확률 분포의 차이를 구하기 위해서 사용됩니다.
- 실제 데이터의 확률 분포와, 학습된 모델이 계산한 확률 분포의 차이를 구하는데 사용된다.

<img src = "https://user-images.githubusercontent.com/109534450/229391092-b4e0e45c-8d9d-4ff4-b7b3-c1716b6b945f.png" width="55%" height="55%">


### **🔧 개발 환경**
- Google Colab
- Jupyter Hub


## 🏃 Team Group

**Front End** <br />
😎 _김지환_
😎 _류원창_

**Back End** <br />
😎 _이지은_
😎 _정현석_

**AI** <br />
💮*소채린*
💮 _조용관_

<br />
# 브랜치 전략

- main: 출시 전 까지 작업 X
  - dev : 분야별 기능 합쳐서 테스트
    - AI : AI 관련 완료된 기능
      - cho
      - so
    - BE : BE 관련 완료된 기능
      - cheong
      - lee
    - FE : FE 관련 완료된 기능
      - kim
      - ryu

# Commit Message Convention

YYMMDD_AI_AUTHOR_TYPE_CONTENT

230207_BE_CHEONG_INIT_AddUserRepository

## TYPE

- INIT : 신규 파일 생성
- FEAT : 신규 기능 생성
- MODI : 기능 수정
- FIX : 버그 수정
- TEST : 테스트
