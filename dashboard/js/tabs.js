var $crtTab = $('#tab-1');

$('ul.menu li').click(function (e) {
    $t = $(e.target);
    var tabID = $t.data('tab');
    var $newTab = $('#' + tabID);
    var $tabContainer = $('#tab-container');
    $crtTab.hide();
    $newTab.show();
    $crtTab = $newTab;
});