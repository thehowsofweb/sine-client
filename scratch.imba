	
	# def createUser
	# 	const data = {username, password, email}
	# 	console.log data
	# 	await window.fetch 'http://localhost:3000/users/add', {
	# 		method: 'POST',
	# 		headers: {'Content-Type': 'application/json'},
	# 		body: JSON.stringify data
	# 	}

	# def deleteUser e
	# 	const id = e.detail
	# 	console.log id
	# 	await window.fetch "http://localhost:3000/users/{id}", {
	# 		method: 'DELETE',
	# 	}
	
	# def editUser id
	# 	console.log id
	# 	const updates = {username, password, email}
	# 	await window.fetch "http://localhost:3000/users/{id}", {
	# 		method: 'PATCH',
	# 		headers: {'Content-Type': 'application/json'},
	# 		body: JSON.stringify updates
	# 	}
		

		# 	<delete-user user=user @deleteUser=deleteUser>		
			# <edit-user @editUser=editUser(user.id) showEdit=showEdit> if showEdit
			# if !showEdit
			# 	<add-user @createUser=createUser username=username showEdit=showEdit showAdd=showAdd>
			

# tag delete-user
# 	user
# 	<self>
# 		<ul [d:flex fld:column g:4]>
# 			<form @submit=emit("deleteUser", user.id) >
# 				<li> <div [d:flex g:8 jc:space-between]> 
# 					<p> user.username
# 					<p> user.email
# 					<button type="submit"> 'delete'
# 					<button type="button" bind=showEdit> if !showEdit then "Edit" else "Cancel"
	

# tag add-user
# 	<self>
# 		<div [d:flex fld:column g:4 mt:4]>
# 			if !showEdit and !showAdd
# 				<button bind=showAdd [p:2]> "Add User"
# 			<form @submit=emit("createUser") [d:flex fld:column g:1]> if showAdd
# 				<input.formElement type="text" placeholder="username" bind=username>			
# 				<input.formElement type="password" placeholder="password" bind=password>			
# 				<input.formElement type="text" placeholder="email" bind=email>			
# 				<div>
# 					<button.formElement type="button" [w:50%] bind=showAdd> "Cancel"
# 					<button.formElement type="submit" [w:50%]> "Submit"
# 			css .formElement p:2


# tag edit-user
# 	<self>
# 		<form @submit.prevent=emit("editUser", id) [d:flex fld:column g:1]>
# 			css > p:2
# 			<input type="text" placeholder="username">
# 			<input type="text" placeholder="password">	
# 			<input type="email" placeholder="email">
# 			<button type="submit"> "Update"