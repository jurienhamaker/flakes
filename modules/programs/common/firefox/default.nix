{ config, pkgs, ... }:

{
  programs.firefox = {
    enable = true;
    package = pkgs.wrapFirefox pkgs.firefox-unwrapped {
      extraPolicies = {
        DisplayBookmarksToolbar = true;
        Preferences = {
          "browser.toolbars.bookmarks.visibility" = "always";
          "toolkit.legacyUserProfileCustomizations.stylesheets" = true;
          "media.ffmpeg.vaapi.enabled" = true;
        };
      };
    };
    profiles.default = {
      userChrome = ''
              /* 
              ┌─┐┬┌┬┐┌─┐┬  ┌─┐
              └─┐││││├─┘│  ├┤ 
              └─┘┴┴┴┴┴─┘└─┘
              ┌─┐  ┌─┐─┐  ┬      
              ├  ┤  │  │┌┴┬┘      
              └  └─┘  ┴└─
              by Miguel Avila
              */
              /*
              
              ┌─┐┌─┐┌┐┌┌─┐┬┌─┐┬ ┬┬─┐┌─┐┌┬┐┬┌─┐┌┐┌
              │  ││  │││├┤ ││ ┬│ │├┬┘├─┤ │ ││ ││││
              └─┘└─┘┘└┘└  ┴└─┘└─┘┴└─┴ ┴ ┴ ┴└─┘┘└┘
              */
              :root {
                --sfwindow: #050505;
                --sfsecondary: #000;
              }
              /* Urlbar View */
              /*─────────────────────────────*/
              /* Comment this section if you */
              /* want to show the URL Bar    */
              /*─────────────────────────────*/
              .urlbarView {
                /* display: none !important; */
              }
              /*─────────────────────────────*/
              /* 
              ┌─┐┌─┐┬  ┌─┐┬─┐┌─┐
              │  │ ││  │ │├┬┘└─┐
              └─┘└─┘┴─┘└─┘┴└─└─┘ 
              */
              /* Tabs colors  */
              #tabbrowser-tabs:not([movingtab])
                > #tabbrowser-arrowscrollbox
                > .tabbrowser-tab
                > .tab-stack
                > .tab-background[multiselected='true'],
              #tabbrowser-tabs:not([movingtab])
                > #tabbrowser-arrowscrollbox
                > .tabbrowser-tab
                > .tab-stack
                > .tab-background[selected='true'] {
                background-image: none !important;
                background-color: var(--toolbar-bgcolor) !important;
              }
              /* Inactive tabs color */
              #navigator-toolbox {
                background-color: var(--sfwindow) !important;
              }
              /* Window colors  */
              :root {
                --toolbar-bgcolor: var(--sfsecondary) !important;
                --tabs-border-color: var(--sfsecondary) !important;
                --lwt-sidebar-background-color: var(--sfwindow) !important;
                --lwt-toolbar-field-focus: var(--sfsecondary) !important;
                --tab-min-height: 32px !important;
              }
              /* Sidebar color  */
              #sidebar-box,
              .sidebar-placesTree {
                background-color: var(--sfwindow) !important;
              }
              /* 
              ┌┬┐┌─┐┬  ┌─┐┌┬┐┌─┐            
              ││├┤ │  ├┤  │ ├┤             
              ─┴┘└─┘┴─┘└─┘ ┴ └─┘            
              ┌─┐┌─┐┌┬┐┌─┐┌─┐┌┐┌┌─┐┌┐┌┌┬┐┌─┐
              │  │ ││││├─┘│ ││││├┤ │││ │ └─┐
              └─┘└─┘┴ ┴┴  └─┘┘└┘└─┘┘└┘ ┴ └─┘
              */
              /*
              Hover for favorites
              */
              #navigator-toolbox #PersonalToolbar {
                min-height: 0 !important;
                max-height: 0;
              }
              #navigator-toolbox #PersonalToolbar #personal-bookmarks {
                max-height: 0;
                transition: max-height 0.5s ease-out;
                transition-delay: 500ms;
              }
              #navigator-toolbox:hover #PersonalToolbar {
                max-height: 500px;
                min-height: 0;
              }
              #navigator-toolbox:hover #PersonalToolbar #personal-bookmarks {
                max-height: 500px;
                transition: max-height 0.5s ease-in;
              }
              /* Tabs elements  */
              .tab-close-button {
                /* display: none; */
              }
              .tabbrowser-tab {
                padding-top: 3px !important;
              }
              .tabbrowser-tab:not([pinned]) .tab-icon-image {
                /* display: none !important; */
              }
              #nav-bar:not([tabs-hidden='true']) {
                box-shadow: none;
              }
              #tabbrowser-tabs[haspinnedtabs]:not([positionpinnedtabs])
                > #tabbrowser-arrowscrollbox
                > .tabbrowser-tab[first-visible-unpinned-tab] {
                margin-inline-start: 0 !important;
              }
              :root {
                --toolbarbutton-border-radius: 0 !important;
                --tab-border-radius: 0 !important;
                --tab-block-margin: 0 !important;
              }
              .tab-background {
                border-right: 0px solid rgba(0, 0, 0, 0) !important;
                margin-left: -4px !important;
                border-top-left-radius: 5px !important;
                border-top-right-radius: 5px !important;
              }
              .tabbrowser-tab:is([visuallyselected='true'], [multiselected])
                > .tab-stack
                > .tab-background {
                box-shadow: none !important;
              }
              .tabbrowser-tab[last-visible-tab='true'] {
                padding-inline-end: 0 !important;
              }
              #tabs-newtab-button {
                /* padding-left: 0 !important; */
              }
              /* Url Bar  */
              #urlbar-input-container {
                background-color: var(--sfsecondary) !important;
                border: 1px solid rgba(0, 0, 0, 0) !important;
                text-align:center !important;
              }
              #urlbar-container {
                margin-left: 0 !important;
              }
              #urlbar[focused='true'] > #urlbar-background {
                box-shadow: none !important;
              }
              #navigator-toolbox {
                border: none !important;
              }
              /* Bookmarks bar  */
              .bookmark-item .toolbarbutton-icon {
                /* display: none; */
              }
              toolbarbutton.bookmark-item:not(.subviewbutton) {
                min-width: 1.6em;
              }
              /* Browser */
              #browser {
                padding: 4px;
                background-color: var(--sfsecondary) !important;
              }
              #browser #appcontent {
                overflow: hidden !important;
                border-radius: 6px !important;
              }
              /* Toolbar  */
              #tracking-protection-icon-container,
              /* #urlbar-zoom-button, */
              /* #star-button-box, */
              #pageActionButton,
              #pageActionSeparator,
              /* #tabs-newtab-button, */
              /* #back-button,*/
              /* #PanelUI-button, */
              /* #forward-button, */
              .tab-secondary-label {
                display: none !important;
              }
              .urlbarView-url {
                color: #dedede !important;
              }
              /* Disable elements  */
              #TabsToolbar .titlebar-spacer:first-child {
                display: none !important;
              }
              #context-navigation,
              #context-savepage,
              #context-pocket,
              #context-sendpagetodevice,
              #context-selectall,
              #context-viewsource,
              #context-inspect-a11y,
              #context-sendlinktodevice,
              #context-openlinkinusercontext-menu,
              #context-bookmarklink,
              #context-savelink,
              #context-savelinktopocket,
              #context-sendlinktodevice,
              #context-searchselect,
              #context-sendimage,
              #context-print-selection {
                display: none !important;
              }
              #context_bookmarkTab,
              #context_moveTabOptions,
              #context_sendTabToDevice,
              #context_reopenInContainer,
              #context_selectAllTabs {
                display: none !important;
              }
      '';
    };
  };

}
