function open_menu(e) {
    $(e).siblings(".drop-choices").not(".inuse").css("top", e.offsetHeight + "px").each(function() {
        $(this).css("left", $(e).position().left + "px").css("top", $(e).height() + $(e).position().top + "px")
    }).addClass("active inuse")
}

function close_menu(e) {
    $(e).closest(".drop-choices").removeClass("active inuse")
}

function close_menus(e) {
    $(".drop-choices.inuse").not(".active").removeClass("inuse"), $(".drop-choices.active").removeClass("active").trigger("close_menu"), $(".flairselector").empty(), $(e.target).closest("#search").length == 0 && ($("#moresearchinfo").slideUp(), $("#searchexpando").length == 1 ? $("#searchexpando").slideUp(function() {
        $("#search_showmore").parent().show()
    }) : $("#search_showmore").parent().show())
}

function hover_open_menu(e) {}

function select_tab_menu(e, t) {
    var n = "tabbedpane-" + t,
        r = $(e).parent().parent().parent();
    r.find(".tabmenu li").removeClass("selected"), $(e).parent().addClass("selected"), r.find(".tabbedpane").each(function() {
        this.style.display = this.id == n ? "block" : "none"
    })
}
