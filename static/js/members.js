$(document).ready(e => {
    var members = []
    $(".member-entry").each((i, member) => {
        members.push(member)
    })
    
    $("#member-list").empty()
    
    // cool way to shuffle the array
    members.sort(() => Math.random() - 0.5)

    members.forEach((member, i) => {
        $("#member-list").append(member)
    })
})