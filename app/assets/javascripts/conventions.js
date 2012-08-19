$(document).ready(function() {

    // UJS to collapse AuthRequirement tables
    $('table.auth_requirements thead').css('cursor', 'pointer');
    $("table.auth_requirements tbody").hide();
    $("table.auth_requirements thead tr>:first-child").prepend("<i class='icon-plus'></i> ");
    $("table.auth_requirements thead").click(function () {
        $($(this).parent().find("tbody")).toggle();
        $(this).find("tr>:first-child i").toggleClass('icon-plus icon-minus');
    });

    $('table.auth_requirements').first().before('<a href="#show_all">Show all</a> / <a href="#hide_all">Hide all</a>');
    $('a[href="#show_all"]').click(function() {
        $("table.auth_requirements tbody").show();
        $("table.auth_requirements thead tr>:first-child i.icon-plus").toggleClass('icon-plus icon-minus');
    });
    $('a[href="#hide_all"]').click(function() {
        $("table.auth_requirements tbody").hide();
        $("table.auth_requirements thead tr>:first-child i.icon-minus").toggleClass('icon-plus icon-minus');
    });

    $("table.auth_requirements").each(function() {
        $(this).find("tr th:last-child").remove();
        $(this).find("tr td:last-child").remove();
    });

});