$( document ).on( "pagecreate", "#demo-page", function() {
    console.log("1");
    $( document ).on( "swipeleft", "#demo-page", function( e ) {
        console.log("2");
        if ( $( ".ui-page-active" ).jqmData( "panel" ) !== "open" ) {
            console.log("3");
            $( "#left-panel" ).panel( "open" );
        }
    });
});