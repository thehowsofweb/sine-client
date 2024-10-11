global css body c:warm2 bg:warm8 ff:Arial
global css * list-style:none p:0 m:0 fs:md

const url = "http://localhost:3001/api/users"

let login = false
let showSettings = false
let showLogin = false
let toggleForm = false

tag App
	users = []
	mount=do # this gets users
		const data = await window.fetch url
		users = await data.json()

	addUser=do(e) # this adds a user
		toggleForm = false
		const user = e.detail
		await window.fetch url, {
			method: "POST",
			headers: {
				"Content-Type": "application/json"
			},
			body: JSON.stringify user
		}
		await mount()

	updateUser=do(e)
		const id = e.detail.id
		const updatedUser = e.detail
		await window.fetch "{url}/{id}", {
			method: "PATCH",
			headers: {
				"Content-Type": "application/json"
			},
			body: JSON.stringify updatedUser
		}

	deleteUser=do(e)
		const id = e.detail
		console.log `deleting user id {id}`
		
		try
			await window.fetch "{url}/{id}", {
				method: "DELETE"
			}
			await mount()
		catch err
			console.log err

	def render # this renders the view of the app
		<self [p:4 inset:0 d:vcc]>
			<div [ta:center mb:4 fs:3xl]> 
				"Node Sqlite3 Imba"
			if !toggleForm
				<button bind=toggleForm [p:2 rd:lg pos:absolute b:8 r:8]> "Add User"

			<%app-container>
				<div [d:flex fld:column g:2 mb:2]> 
					for user  in users
						<user-item user=user @deleteUser=deleteUser @refresh=mount @updateUser=updateUser>

			if toggleForm
				<modal-layer>
				<user-add-form @addUser=addUser>

			if showLogin
				<modal-layer>
				<user-login-form>


tag modal-layer
	<self>
		<div [bgc:gray8 h:100% w:100% o:.8 inset:0 zi:0] >

tag user-add-form
	prop username=""
	prop password=""
	prop email=""

	def render
		const user = {username, password, email}
		<self [inset:0 d:vcc]>
			<form @submit.prevent=emit("addUser", user) [d:flex fld:column jc:space-between bd:1px rd:lg p:4 miw:400px]>
				css d:flex fld:column
				<label> "Username"
				<input type="text" placeholder="username" bind=username>		
					css p:2 rd:lg ta:center
				<label> "Password"
				<input type="text" placeholder="password" bind=password>			
					css p:2 rd:lg ta:center
				<label> "Email"
				<input type="email" placeholder="email" bind=email>			
					css p:2 rd:lg ta:center
				<div [d:flex mt:2]>
					css > w:100% p:2 rd:lg
					<button> "Add User"
					<button type="button" bind=toggleForm> "Cancel"

tag header-container
	def render
		<self [pos:fixed w:100vw zi:1]>
			<div[d:hcs p:4 bd:white]>
				<div> "The HoW"
				<div [pos:relative]>
					css > bd:none bgc:clear c:white
					if login
						<button bind=showSettings [c@hover:blue4 cursor@hover:pointer]> "user"
					else
						<button [c@hover:blue4 cursor@hover:pointer] bind=showLogin> "login"
					if showSettings
						<%settings [pos:absolute t:5 r:0 p:2 bgc:gray5 zi:3]>
							<ul [d:vcc]>
								css > c@hover:red2 cursor@hover:pointer
								<li> "profile"
								<li @click=handleLogout> "logout"
			

tag user-login-form
	prop username=""
	prop password=""

	def render
		const user = {username, password}
		<self [inset:0 d:vcc]>
			<form @submit.prevent=emit("addUser", user) [d:flex fld:column jc:space-between bd:1px rd:lg p:4 miw:400px]>
				css d:flex fld:column
				<label> "Username"
				<input type="text" placeholder="username" bind=username>		
					css p:2 rd:lg ta:center
				<label> "Password"
				<input type="text" placeholder="password" bind=password>			
					css p:2 rd:lg ta:center
				<div [d:flex mt:2]>
					css > w:100% p:2 rd:lg
					<button> "Add User"
					<button type="button" bind=showLogin> "Cancel"


tag user-item
	prop user
	prop editting=no

	def render
		console.log "user is {JSON.stringify user}"
		const updatedUser = user
		console.log "updated user is {JSON.stringify updatedUser}"
		<self>
			<div [d:flex g:2]>
				css > p:2 c:gray 
					bd:none 
				<input bind=user.username readOnly=!editting [ol:none bgc:clear]=!editting>
				<input bind=user.email readOnly=!editting [ol:none bgc:clear]=!editting>
				if editting
					<button [c:blue4 bgc:clear] bind=editting @click=emit('updateUser', updatedUser)> "save"
					<button [c:blue4 bgc:clear] bind=editting @click=emit('refresh')> "cancel"
				else
					<button [c:blue4 bgc:clear] bind=editting> "edit"
					<button [c:red3 bgc:clear] @click=emit("deleteUser", user.id) > "delete"


imba.mount do <div>
	<header-container>
	<App>