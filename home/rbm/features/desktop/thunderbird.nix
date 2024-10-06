{pkgs, ...}: {
  home.packages = [pkgs.protonmail-bridge-gui];
  programs.thunderbird = {
    enable = false;

    profiles = {
      main = {
        isDefault = true;

        settings = {
          /*
            *****
          * name: thunderbird user.js
          * date: 21 April 2024
          * version: v115.0
          * url: https://github.com/HorlogeSkynet/thunderbird-user.js
          * license: MIT (https://github.com/HorlogeSkynet/thunderbird-user.js/blob/master/LICENSE)

          * INDEX:

            0100: STARTUP
            0200: GEOLOCATION / LANGUAGE / LOCALE
            0300: QUIETER BIRD
            0400: SAFE BROWSING
            0600: BLOCK IMPLICIT OUTBOUND
            0700: DNS / DoH / PROXY / SOCKS
            0800: LOCATION BAR / SEARCH BAR / SUGGESTIONS / HISTORY / FORMS
            0900: PASSWORDS
            1000: DISK AVOIDANCE
            1200: HTTPS (SSL/TLS / OCSP / CERTS / HPKP)
            1400: FONTS
            1600: REFERERS
            1700: CONTAINERS
            2000: PLUGINS / MEDIA / WEBRTC
            2400: DOM (DOCUMENT OBJECT MODEL)
            2600: MISCELLANEOUS
            2700: ETP (ENHANCED TRACKING PROTECTION)
            2800: SHUTDOWN & SANITIZING
            4500: RFP (RESIST FINGERPRINTING)
            5000: OPTIONAL OPSEC
            5500: OPTIONAL HARDENING
            6000: DON'T TOUCH
            7000: DON'T BOTHER
            8000: DON'T BOTHER: FINGERPRINTING
            9000: NON-PROJECT RELATED
            9100: THUNDERBIRD (AUTO CONFIG / UI / HEADERS / ADDRESS BOOK)
            9200: EMAIL COMPOSITION (ENCODING / FORMAT / VIEW)
            9300: OTHER THUNDERBIRD COMPONENTS (CHAT / CALENDAR / RSS)
            9400: THUNDERBIRD ENCRYPTION (OPENPGP / GNUPG)
            9999: DEPRECATED / REMOVED / LEGACY / RENAMED

          *****
          */

          /*
          * NOTE: Not all syntax errors cause parsing to abort i.e. reaching the last debug pref
          * no longer necessarily means that all prefs have been applied. Check the console right
          * after startup for any warnings/error messages related to non-applied prefs
          * [1] https://blog.mozilla.org/nnethercote/2018/03/09/a-new-preferences-parser-for-firefox/ **
          */

          /*
          0000: disable about:config warning **
          */
          "browser.aboutConfig.showWarning" = false;

          /*
          ** [SECTION 0100]: STARTUP **
          */
          /*
            0102: set START page [SETUP-CHROME]
          * [SETTING] General > Thunderbird Start Page **
          */
          "mailnews.start_page.enabled" = false;
          /*
            0104: set NEWTAB page
          * true=? (default), false=blank page **
          */
          "browser.newtabpage.enabled" = false;

          /*
          ** [SECTION 0200]: GEOLOCATION / LANGUAGE / LOCALE **
          */
          /*
            0201: use Mozilla geolocation service instead of Google if permission is granted [FF74+]
          * Optionally enable logging to the console (defaults to false) **
          */
          "geo.provider.network.url" = "https://location.services.mozilla.com/v1/geolocate?key=%MOZILLA_API_KEY%";
          "geo.provider.network.logging.enabled" = true; ## [HIDDEN PREF]
          /*
          0202: disable using the OS's geolocation service **
          */
          "geo.provider.ms-windows-location" = false; ## [WINDOWS]
          "geo.provider.use_corelocation" = false; ## [MAC]
          "geo.provider.use_gpsd" = false; ## [LINUX]
          "geo.provider.use_geoclue" = false; ## [FF102+] [LINUX]
          /*
            0210: set preferred language for displaying pages
          * [SETTING] General > Language & Appearance > Language > Choose the language used to display...
          * [TEST] https://addons.mozilla.org/about **
          */
          "intl.accept_languages" = "en-US, en";
          /*
          0210b: Set dictionary to US **
          */
          "spellchecker.dictionary" = "en-US";
          /*
            0211: use en-US locale regardless of the system or region locale
          * [SETUP-WEB] May break some input methods e.g xim/ibus for CJK languages [1]
          * [1] https://bugzilla.mozilla.org/buglist.cgi?bug_id=867501,1629630 **
          */
          "javascript.use_us_english_locale" = true; ## [HIDDEN PREF]

          /*
          ** [SECTION 0300]: QUIETER BIRD **
          */
          /*
          * RECOMMENDATIONS **
          */
          /*
          0320: disable recommendation pane in about:addons (uses Google Analytics) **
          */
          "extensions.getAddons.showPane" = false; ## [HIDDEN PREF]
          /*
          0321: disable recommendations in about:addons' Extensions and Themes panes [FF68+] **
          */
          "extensions.htmlaboutaddons.recommendations.enabled" = false;

          /*
          * TELEMETRY **
          */
          /*
            0330: disable new data submission [FF41+]
          * If disabled, no policy is shown or upload takes place, ever
          * [1] https://bugzilla.mozilla.org/1195552
          * [2] https://searchfox.org/comm-esr115/source/mail/components/telemetry/README.md#165 **
          */
          "datareporting.policy.dataSubmissionEnabled" = false;
          "datareporting.policy.dataSubmissionPolicyBypassNotification" = true;
          /*
            0331: disable Health Reports
          * [SETTING] Privacy & Security > Thunderbird Data Collection and Use > Allow Thunderbird to send technical... **
          */
          "datareporting.healthreport.uploadEnabled" = false;
          /*
            0332: disable telemetry
          * The "unified" pref affects the behavior of the "enabled" pref
          * - If "unified" is false then "enabled" controls the telemetry module
          * - If "unified" is true then "enabled" only controls whether to record extended data
          * NOTE: "toolkit.telemetry.enabled" is now LOCKED to reflect prerelease (true) or release builds (false) [2]
          * [1] https://firefox-source-docs.mozilla.org/toolkit/components/telemetry/telemetry/internals/preferences.html
          * [2] https://medium.com/georg-fritzsche/data-preference-changes-in-firefox-58-2d5df9c428b5 **
          */
          "toolkit.telemetry.unified" = false;
          "toolkit.telemetry.enabled" = false; ## see NOTE:
          "toolkit.telemetry.server" = "data:,";
          "toolkit.telemetry.archive.enabled" = false;
          "toolkit.telemetry.newProfilePing.enabled" = false; ## [FF55+]
          "toolkit.telemetry.shutdownPingSender.enabled" = false; ## [FF55+]
          "toolkit.telemetry.updatePing.enabled" = false; ## [FF56+]
          "toolkit.telemetry.bhrPing.enabled" = false; ## [FF57+] Background Hang Reporter
          "toolkit.telemetry.firstShutdownPing.enabled" = false; ## [FF57+]
          /*
            0333: disable Telemetry Coverage
          * [1] https://blog.mozilla.org/data/2018/08/20/effectively-measuring-search-in-firefox/ **
          */
          "toolkit.telemetry.coverage.opt-out" = true; ## [HIDDEN PREF]
          "toolkit.coverage.opt-out" = true; ## [FF64+] [HIDDEN PREF]
          "toolkit.coverage.endpoint.base" = "";
          /*
            0334: disable PingCentre telemetry (used in several System Add-ons) [FF57+]
          * Defense-in-depth: currently covered by 0331 **
          */
          "browser.ping-centre.telemetry" = false;

          /*
          * STUDIES **
          */
          /*
            0340: disable Studies
          * NOTE: This option is missing from Thunderbird's preferences panel (hidden?) **
          */
          "app.shield.optoutstudies.enabled" = false;
          /*
            0341: disable Normandy/Shield [FF60+]
          * Shield is a telemetry system that can push and test "recipes"
          * [1] https://mozilla.github.io/normandy/ **
          */
          "app.normandy.enabled" = false;
          "app.normandy.api_url" = "";

          /*
          * CRASH REPORTS **
          */
          /*
          0350: disable Crash Reports **
          */
          "breakpad.reportURL" = "";
          "browser.tabs.crashReporting.sendReport" = false; ## [FF44+]
          "browser.crashReports.unsubmittedCheck.enabled" = false; ## [FF51+] [DEFAULT: false]
          /*
            0351: enforce no submission of backlogged Crash Reports [FF58+]
          * [SETTING] Privacy & Security > Thunderbird Data Collection and Use > Allow Thunderbird to send backlogged crash reports... **
          */
          "browser.crashReports.unsubmittedCheck.autoSubmit2" = false; ## [DEFAULT: false]

          /*
          * OTHER **
          */
          /*
            0360: disable Captive Portal detection
          * [1] https://www.eff.org/deeplinks/2017/08/how-captive-portals-interfere-wireless-security-and-privacy **
          */
          "captivedetect.canonicalURL" = "";
          "network.captive-portal-service.enabled" = false; ## [FF52+]
          /*
            0361: disable Network Connectivity checks [FF65+]
          * [1] https://bugzilla.mozilla.org/1460537 **
          */
          "network.connectivity-service.enabled" = false;
          /*
          0370: disable UI instrumentation **
          */
          "mail.instrumentation.postUrl" = "";
          "mail.instrumentation.askUser" = false;
          "mail.instrumentation.userOptedIn" = false;
          /*
            0371: disable about:rights notification on fresh profiles
          * When a profile is loaded for the first time, a bottom notification appears with a button
          * showing "Know your rights...". If clicked, the _special_ page about:rights appears.
          * When `mail.rights.override` is unset (default), Thunderbird falls-back on `mail.rights.version`
          * value. If it's unset (default too) or lower than the current version, notification is displayed.
          * false=always show the notification
          * true=never show the notification
          * [1] https://searchfox.org/comm-esr102/source/mail/base/content/specialTabs.js#1266 **
          */
          "mail.rights.override" = true; ## [DEFAULT: unset]
          "mail.rights.version" = 1; ## [DEFAULT: unset]
          /*
            0372: allow Thunderbird usage without any configured email account [SETUP-INSTALL]
          * NOTE: Only enable this if you don't plan to use emails at all and want to hide the account setup **
          */
          "app.use_without_mail_account" = false;
          /*
          0373: disable warning when customizing "From address" **
          */
          "mail.compose.warned_about_customize_from" = true;
          /*
            0374: prevent donation appeal page opening on fresh profiles
          * $url Web page is opened if $viewed is lower than $version (and 0330 policy bypass notification is disabled)
          * [1] https://searchfox.org/comm-esr115/source/mail/base/content/messenger.js#455 **
          */
          "app.donation.eoy.version" = 2;
          "app.donation.eoy.version.viewed" = 999;
          "app.donation.eoy.url" = "https://www.thunderbird.net/thunderbird/115.0/appeal/";
          /*
            0380: disable the new/unread message count badge on taskbar icon
          * [1] https://www.thunderbird.net/en-US/thunderbird/91.0.2/releasenotes/#whatsnew
          */
          "mail.biff.show_badge" = false; ## [WINDOWS]
          /*
          0381: show the number of "new" messages on taskbar icon (not the number of unread ones) **
          */
          "mail.biff.use_new_count_in_badge" = true;
          /*
            0390: disable new email alerts
          * [SETTING] General > Incoming Mails > When new messages arrive > Show an alert **
          */
          "mail.biff.show_alert" = false;
          /*
            0391: control the kind of information disclosed in new email alerts
          * These preferences MAY be appreciated in environments with inquisitive eyes wandering behind your screen.
          * [SETTING] General > Incoming Mails > When new messages arrive > Show an alert > Customize... **
          */
          "mail.biff.alert.show_preview" = false;
          "mail.biff.alert.show_subject" = false;
          "mail.biff.alert.show_sender" = false;
          "mail.biff.alert.preview_length" = 40; ## [HIDDEN PREF]

          /*
            ** [SECTION 0400]: SAFE BROWSING (SB)
             SB has taken many steps to preserve privacy. If required, a full url is never sent
             to Google, only a part-hash of the prefix, hidden with noise of other real part-hashes.
             Thunderbird takes measures such as stripping out identifying parameters and since SBv4 (FF57+)
             doesn't even use cookies. (#Turn on browser.safebrowsing.debug to monitor this activity)

             [1] https://feeding.cloud.geek.nz/posts/how-safe-browsing-works-in-firefox/
             [2] https://wiki.mozilla.org/Security/Safe_Browsing
             [3] https://support.mozilla.org/kb/how-does-phishing-and-malware-protection-work
             [4] https://educatedguesswork.org/posts/safe-browsing-privacy/
          **
          */
          /*
            0401: disable SB (Safe Browsing)
          * [WARNING] Do this at your own risk! These are the master switches **
          */
          "browser.safebrowsing.malware.enabled" = false;
          "browser.safebrowsing.phishing.enabled" = false;
          /*
            0402: disable SB checks for downloads (both local lookups + remote)
          * This is the master switch for the safebrowsing.downloads* prefs (0403, 0404) **
          */
          "browser.safebrowsing.downloads.enabled" = false;
          /*
            0403: disable SB checks for downloads (remote)
          * To verify the safety of certain executable files, Thunderbird may submit some information about the
          * file, including the name, origin, size and a cryptographic hash of the contents, to the Google
          * Safe Browsing service which helps Thunderbird determine whether or not the file should be blocked
          * [SETUP-SECURITY] If you do not understand this, or you want this protection, then override this **
          */
          "browser.safebrowsing.downloads.remote.enabled" = false;
          "browser.safebrowsing.downloads.remote.url" = ""; ## Defense-in-depth
          /*
          0404: disable SB checks for unwanted software **
          */
          "browser.safebrowsing.downloads.remote.block_potentially_unwanted" = false;
          "browser.safebrowsing.downloads.remote.block_uncommon" = false;
          /*
            0405: disable "ignore this warning" on SB warnings [FF45+]
          * If clicked, it bypasses the block for that session. This is a means for admins to enforce SB
          * [TEST] see https://github.com/arkenfox/user.js/wiki/Appendix-A-Test-Sites#-mozilla
          * [1] https://bugzilla.mozilla.org/1226490 **
          */
          "browser.safebrowsing.allowOverride" = false;

          /*
          ** [SECTION 0600]: BLOCK IMPLICIT OUTBOUND [not explicitly asked for - e.g. clicked on] **
          */
          /*
            0601: disable link prefetching
          * [1] https://developer.mozilla.org/docs/Web/HTTP/Link_prefetching_FAQ **
          */
          "network.prefetch-next" = false;
          /*
            0602: disable DNS prefetching
          * [1] https://developer.mozilla.org/docs/Web/HTTP/Headers/X-DNS-Prefetch-Control **
          */
          "network.dns.disablePrefetch" = true;
          "network.dns.disablePrefetchFromHTTPS" = true; ## [DEFAULT: true]
          /*
          0603: disable predictor / prefetching **
          */
          "network.predictor.enabled" = false;
          "network.predictor.enable-prefetch" = false; ## [FF48+] [DEFAULT: false]
          /*
            0604: disable link-mouseover opening connection to linked server
          * [1] https://news.slashdot.org/story/15/08/14/2321202/how-to-quash-firefoxs-silent-requests **
          */
          "network.http.speculative-parallel-limit" = 0;
          /*
            0610: enforce no "Hyperlink Auditing" (click tracking)
          * [1] https://www.bleepingcomputer.com/news/software/major-browsers-to-prevent-disabling-of-click-tracking-privacy-risk/ **
          */
          "browser.send_pings" = false; ## [DEFAULT: false]
          /*
            0610: don't refresh nor reload pages when tab/window is not active or in idle state
          * [1] https://bugzilla.mozilla.org/show_bug.cgi?id=518805 **
          */
          "browser.meta_refresh_when_inactive.disabled" = true;

          /*
          ** [SECTION 0700]: DNS / DoH / PROXY / SOCKS **
          */
          /*
            0702: set the proxy server to do any DNS lookups when using SOCKS
          * e.g. in Tor, this stops your local DNS server from knowing your Tor destination
          * as a remote Tor node will handle the DNS request
          * [1] https://trac.torproject.org/projects/tor/wiki/doc/TorifyHOWTO/WebBrowsers **
          */
          "network.proxy.socks_remote_dns" = true;
          /*
            0703: disable using UNC (Uniform Naming Convention) paths [FF61+]
          * [SETUP-CHROME] Can break extensions for profiles on network shares
          * [1] https://gitlab.torproject.org/tpo/applications/tor-browser/-/issues/26424 **
          */
          "network.file.disable_unc_paths" = true; ## [HIDDEN PREF]
          /*
            0704: disable GIO as a potential proxy bypass vector [FF60+]
          * Gvfs/GIO has a set of supported protocols like obex, network, archive, computer,
          * dav, cdda, gphoto2, trash, etc. By default only sftp is accepted (FF87+)
          * [1] https://bugzilla.mozilla.org/1433507
          * [2] https://en.wikipedia.org/wiki/GVfs
          * [3] https://en.wikipedia.org/wiki/GIO_(software) **
          */
          "network.gio.supported-protocols" = ""; ## [HIDDEN PREF]
          /*
            0705: disable proxy direct failover for system requests [FF91+]
          * [WARNING] Default true is a security feature against malicious extensions [1]
          * [SETUP-CHROME] If you use a proxy and you trust your extensions
          * [1] https://blog.mozilla.org/security/2021/10/25/securing-the-proxy-api-for-firefox-add-ons/ **
          */
          "network.proxy.failover_direct" = false;
          /*
            0706: disable proxy bypass for system request failures [FF95+]
          * RemoteSettings, UpdateService, Telemetry [1]
          * [WARNING] If false, this will break the fallback for some security features
          * [SETUP-CHROME] If you use a proxy and you understand the security impact
          * [1] https://bugzilla.mozilla.org/buglist.cgi?bug_id=1732792,1733994,1733481 **
          */
          "network.proxy.allow_bypass" = false;
          /*
             0710: disable DNS-over-HTTPS (DoH) rollout [FF60+]
           * 0=default, 2=increased (TRR (Trusted Recursive Resolver) first), 3=max (TRR only), 5=off
           * see "doh-rollout.home-region": USA 2019, Canada 2021, Russia/Ukraine 2022 [3]
           * [SETTING] General > Network & Disk Space > Connection > Settings... > Enable DNS over HTTPS
           * [1] https://hacks.mozilla.org/2018/05/a-cartoon-intro-to-dns-over-https/
           * [2] https://wiki.mozilla.org/Security/DOH-resolver-policy
          * [3] https://support.mozilla.org/en-US/kb/firefox-dns-over-https
           * [4] https://www.eff.org/deeplinks/2020/12/dns-doh-and-odoh-oh-my-year-review-2020 **
          */
          "network.trr.mode" = 5;

          /*
          ** [SECTION 0800]: LOCATION BAR / SEARCH BAR / SUGGESTIONS / HISTORY / FORMS **
          */
          /*
            0802: disable location bar domain guessing
          * domain guessing intercepts DNS "hostname not found errors" and resends a
          * request (e.g. by adding www or .com). This is inconsistent use (e.g. FQDNs), does not work
          * via Proxy Servers (different error), is a flawed use of DNS (TLDs: why treat .com
          * as the 411 for DNS errors?), privacy issues (why connect to sites you didn't
          * intend to), can leak sensitive data (e.g. query strings: e.g. Princeton attack),
          * and is a security risk (e.g. common typos & malicious sites set up to exploit this) **
          */
          "browser.fixup.alternate.enabled" = false; ## [DEFAULT: false FF104+]
          /*
            0804: disable live search suggestions
          * NOTE: Both must be true for the location bar to work
          * [SETUP-CHROME] Override this if you trust and use a privacy respecting search engine **
          */
          "browser.search.suggest.enabled" = false;
          /*
            0810: disable search and form history
          * [SETUP-WEB] Be aware that autocomplete form data can be read by third parties [1][2]
          * NOTE: We also clear formdata on exit (2811)
          * [1] https://blog.mindedsecurity.com/2011/10/autocompleteagain.html
          * [2] https://bugzilla.mozilla.org/381681 **
          */
          "browser.formfill.enable" = false;
          /*
            0820: disable coloring of visited links
          * Bulk rapid history sniffing was mitigated in 2010 [1][2]. Slower and more expensive
          * redraw timing attacks were largely mitigated in FF77+ [3]. Using RFP (4501) further hampers timing
          * attacks. Don't forget clearing history on exit (2811). However, social engineering [2#limits][4][5]
          * and advanced targeted timing attacks could still produce usable results
          * [1] https://developer.mozilla.org/docs/Web/CSS/Privacy_and_the_:visited_selector
          * [2] https://dbaron.org/mozilla/visited-privacy
          * [3] https://bugzilla.mozilla.org/1632765
          * [4] https://earthlng.github.io/testpages/visited_links.html (see github wiki APPENDIX A on how to use)
          * [5] https://lcamtuf.blogspot.com/2016/08/css-mix-blend-mode-is-bad-for-keeping.html **
          */
          "layout.css.visited_links_enabled" = false;

          /*
            ** [SECTION 0900]: PASSWORDS
             [1] https://support.mozilla.org/kb/use-primary-password-protect-stored-logins-and-pas
          **
          */
          /*
            0903: disable auto-filling username & password form fields
          * can leak in cross-site forms *and* be spoofed
          * NOTE: Username & password is still available when you enter the field
          * [1] https://freedom-to-tinker.com/2017/12/27/no-boundaries-for-user-identities-web-trackers-exploit-browser-login-managers/
          * [2] https://homes.esat.kuleuven.be/~asenol/leaky-forms/ **
          */
          "signon.autofillForms" = false;
          /*
          0904: disable formless login capture for Password Manager [FF51+] **
          */
          "signon.formlessCapture.enabled" = false;
          /*
            0905: limit (or disable) HTTP authentication credentials dialogs triggered by sub-resources [FF41+]
          * hardens against potential credentials phishing
          * 0 = don't allow sub-resources to open HTTP authentication credentials dialogs
          * 1 = don't allow cross-origin sub-resources to open HTTP authentication credentials dialogs
          * 2 = allow sub-resources to open HTTP authentication credentials dialogs (default) **
          */
          "network.auth.subresource-http-auth-allow" = 1;
          /*
            0906: enforce no automatic authentication on Microsoft sites [FF91+] [WINDOWS 10+]
          * [1] https://support.mozilla.org/kb/windows-sso **
          */
          "network.http.windows-sso.enabled" = false; ## [DEFAULT: false]
          /*
            0910: prevent access to emails until the master password is entered
          * If a master password has been set, Thunderbird will prevent access to locally available emails
          * until the secret is provided.
          * This preference MAY mitigate risk due to intimate relationship threat in some cases (see [2])...
          * [WARNING] This DOES NOT encrypt locally cached emails anyhow (poor man's application security)
          * [WARNING] This preference is very buggy, you might not manage to start Thunderbird when it's switched on
          * [1] https://support.mozilla.org/en-US/kb/protect-your-thunderbird-passwords-master-password
          * [2] https://www.schneier.com/wp-content/uploads/2020/06/Privacy_Threats_in_Intimate_Relationships-1.pdf **
          */
          "mail.password_protect_local_cache" = true; ## [HIDDEN PREF]

          /*
          ** [SECTION 1000]: DISK AVOIDANCE **
          */
          /*
            1001: disable disk cache
          * [SETUP-CHROME] If you think disk cache helps perf, then feel free to override this
          * NOTE: We also clear cache on exit (2811) **
          */
          "browser.cache.disk.enable" = false;
          /*
            1002: disable media cache from writing to disk in Private Browsing
          * NOTE: MSE (Media Source Extensions) are already stored in-memory in PB **
          */
          "browser.privatebrowsing.forceMediaMemoryCache" = true; ## [FF75+]
          "media.memory_cache_max_size" = 65536;
          /*
            1003: disable storing extra session data [SETUP-CHROME]
          * define on which sites to save extra session data such as form content, cookies and POST data
          * 0=everywhere, 1=unencrypted sites, 2=nowhere **
          */
          "browser.sessionstore.privacy_level" = 2;
          /*
          1901: disable disk cache for messages not in offline store
          */
          "mail.imap.use_disk_cache2" = false;

          /*
            ** [SECTION 1200]: HTTPS (SSL/TLS / OCSP / CERTS / HPKP)
             Your cipher and other settings can be used in server side fingerprinting
             [TEST] https://www.ssllabs.com/ssltest/viewMyClient.html
             [TEST] https://browserleaks.com/ssl
             [TEST] https://ja3er.com/
             [1] https://www.securityartwork.es/2017/02/02/tls-client-fingerprinting-with-bro/
          **
          */
          /*
          * SSL (Secure Sockets Layer) / TLS (Transport Layer Security) **
          */
          /*
            1201: require safe negotiation
          * Blocks connections to servers that don't support RFC 5746 [2] as they're potentially vulnerable to a
          * MiTM attack [3]. A server without RFC 5746 can be safe from the attack if it disables renegotiations
          * but the problem is that the browser can't know that. Setting this pref to true is the only way for the
          * browser to ensure there will be no unsafe renegotiations on the channel between the browser and the server
          * [SETUP-WEB] SSL_ERROR_UNSAFE_NEGOTIATION: is it worth overriding this for that one site?
          * [STATS] SSL Labs (Feb 2023) reports over 99.3% of top sites have secure renegotiation [4]
          * [1] https://wiki.mozilla.org/Security:Renegotiation
          * [2] https://datatracker.ietf.org/doc/html/rfc5746
          * [3] https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2009-3555
          * [4] https://www.ssllabs.com/ssl-pulse/ **
          */
          "security.ssl.require_safe_negotiation" = false;
          /*
            1206: disable TLS1.3 0-RTT (round-trip time) [FF51+]
          * This data is not forward secret, as it is encrypted solely under keys derived using
          * the offered PSK. There are no guarantees of non-replay between connections
          * [1] https://github.com/tlswg/tls13-spec/issues/1001
          * [2] https://www.rfc-editor.org/rfc/rfc9001.html#name-replay-attacks-with-0-rtt
          * [3] https://blog.cloudflare.com/tls-1-3-overview-and-q-and-a/ **
          */
          "security.tls.enable_0rtt_data" = false;

          /*
            * OCSP (Online Certificate Status Protocol)
             [1] https://scotthelme.co.uk/revocation-is-broken/
             [2] https://blog.mozilla.org/security/2013/07/29/ocsp-stapling-in-firefox/
          **
          */
          /*
            1211: enforce OCSP fetching to confirm current validity of certificates
          * 0=disabled, 1=enabled (default), 2=enabled for EV certificates only
          * OCSP (non-stapled) leaks information about the sites you visit to the CA (cert authority)
          * It's a trade-off between security (checking) and privacy (leaking info to the CA)
          * NOTE: This pref only controls OCSP fetching and does not affect OCSP stapling
          * [SETTING] Privacy & Security > Security > Certificates > Query OCSP responder servers to confirm
          * [1] https://en.wikipedia.org/wiki/Ocsp **
          */
          "security.OCSP.enabled" = 1; ## [DEFAULT: 1]
          /*
            1212: set OCSP fetch failures (non-stapled, see 1211) to hard-fail
          * [SETUP-WEB] SEC_ERROR_OCSP_SERVER_ERROR
          * When a CA cannot be reached to validate a cert, Thunderbird's just continues the connection (=soft-fail)
          * Setting this pref to true tells Thunderbird's to instead terminate the connection (=hard-fail)
          * It is pointless to soft-fail when an OCSP fetch fails: you cannot confirm a cert is still valid (it
          * could have been revoked) and/or you could be under attack (e.g. malicious blocking of OCSP servers)
          * [1] https://blog.mozilla.org/security/2013/07/29/ocsp-stapling-in-firefox/
          * [2] https://www.imperialviolet.org/2014/04/19/revchecking.html **
          */
          "security.OCSP.require" = true;

          /*
          * CERTS / HPKP (HTTP Public Key Pinning) **
          */
          /*
            1221: disable Windows 8.1's Microsoft Family Safety cert [FF50+] [WINDOWS]
          * 0=disable detecting Family Safety mode and importing the root
          * 1=only attempt to detect Family Safety mode (don't import the root)
          * 2=detect Family Safety mode and import the root
          * [1] https://gitlab.torproject.org/tpo/applications/tor-browser/-/issues/21686 **
          */
          "security.family_safety.mode" = 0;
          /*
            1223: enable strict PKP (Public Key Pinning)
          * 0=disabled, 1=allow user MiTM (default; such as your antivirus), 2=strict
          * [SETUP-WEB] MOZILLA_PKIX_ERROR_KEY_PINNING_FAILURE
          * [SETUP-INSTALL] It needs to be set to 1 when connecting to the ProtonMail Bridge for the first time **
          */
          "security.cert_pinning.enforcement_level" = 2;
          /*
            1224: enable CRLite [FF73+]
          * 0 = disabled
          * 1 = consult CRLite but only collect telemetry
          * 2 = consult CRLite and enforce both "Revoked" and "Not Revoked" results
          * 3 = consult CRLite and enforce "Not Revoked" results, but defer to OCSP for "Revoked" (FF99+, default FF100+)
          * [1] https://bugzilla.mozilla.org/buglist.cgi?bug_id=1429800,1670985,1753071
          * [2] https://blog.mozilla.org/security/tag/crlite/ **
          */
          "security.remote_settings.crlite_filters.enabled" = true;
          "security.pki.crlite_mode" = 2;
          /*
            1225: enable loading of client certificates stored in OS certificate storage
          * Bug: this does **NOT** work for S/MIME [1]
          * [1] https://bugzilla.mozilla.org/show_bug.cgi?id=1726442 **
          */
          "security.osclientcerts.autoload" = true;

          /*
          * MIXED CONTENT **
          */
          /*
          1241: disable insecure passive content (such as images) on https pages **
          */
          "security.mixed_content.block_display_content" = true; ## Defense-in-depth (see 1244
          /*
            1244: enable HTTPS-Only mode in all windows [FF76+]
          * When the top-level is HTTPS, insecure subresources are also upgraded (silent fail)
          * [TEST] http://example.com [upgrade]
          * [TEST] http://httpforever.com/ | http://http.rip [no upgrade] **
          */
          "dom.security.https_only_mode" = true; ## [FF76+]
          "dom.security.https_only_mode_pbm" = true; ## [FF80+]
          /*
          1245: enable HTTPS-Only mode for local resources [FF77+] **
          */
          "dom.security.https_only_mode.upgrade_local" = true;
          /*
            1246: disable HTTP background requests [FF82+]
          * When attempting to upgrade, if the server doesn't respond within 3 seconds, Thunderbird sends
          * a top-level HTTP request without path in order to check if the server supports HTTPS or not
          * This is done to avoid waiting for a timeout which takes 90 seconds
          * [1] https://bugzilla.mozilla.org/buglist.cgi?bug_id=1642387,1660945 **
          */
          "dom.security.https_only_mode_send_http_background_request" = false;

          /*
          * UI (User Interface) **
          */
          /*
            1270: display warning on the padlock for "broken security" (if 1201 is false)
          * Bug: warning padlock not indicated for subresources on a secure page! [2]
          * [1] https://wiki.mozilla.org/Security:Renegotiation
          * [2] https://bugzilla.mozilla.org/1353705 **
          */
          "security.ssl.treat_unsafe_negotiation_as_broken" = true;
          /*
            1272: display advanced information on Insecure Connection warning pages
          * only works when it's possible to add an exception
          * i.e. it doesn't work for HSTS discrepancies (https://subdomain.preloaded-hsts.badssl.com/)
          * [TEST] https://expired.badssl.com/ **
          */
          "browser.xul.error_pages.expert_bad_cert" = true;
          /*
          1280: display warnings when insecure HTTP connections are made **
          */
          "security.warn_entering_weak" = true;
          "security.warn_leaving_secure" = true;
          "security.warn_viewing_mixed" = true;

          /*
          ** [SECTION 1400]: FONTS **
          */
          /*
            1402: limit font visibility (Windows, Mac, some Linux) [FF94+]
          * Uses hardcoded lists with two parts: kBaseFonts + kLangPackFonts [1], bundled fonts are auto-allowed
          * In normal windows: uses the first applicable: RFP (4506) over TP over Standard
          * In Private Browsing windows: uses the most restrictive between normal and private
          * 1=only base system fonts, 2=also fonts from optional language packs, 3=also user-installed fonts
          * [1] https://searchfox.org/mozilla-central/search?path=StandardFonts*.inc **
          */
          "layout.css.font-visibility.private" = 1;
          "layout.css.font-visibility.standard" = 1;
          "layout.css.font-visibility.trackingprotection" = 1;

          /*
            ** [SECTION 1600]: REFERERS
                            full URI: https://example.com:8888/foo/bar.html?id=1234
               scheme+host+port+path: https://example.com:8888/foo/bar.html
                    scheme+host+port: https://example.com:8888
             [1] https://feeding.cloud.geek.nz/posts/tweaking-referrer-for-privacy-in-firefox/
          **
          */
          /*
            1602: control the amount of cross-origin information to send [FF52+]
          * 0=send full URI (default), 1=scheme+host+port+path, 2=scheme+host+port **
          */
          "network.http.referer.XOriginTrimmingPolicy" = 2;

          /*
          ** [SECTION 1700]: CONTAINERS **
          */
          /*
            1701: enable Container Tabs and its UI setting [FF50+]
          * https://wiki.mozilla.org/Security/Contextual_Identity_Project/Containers **
          */
          "privacy.userContext.enabled" = true;
          "privacy.userContext.ui.enabled" = true;

          /*
          ** [SECTION 2000]: PLUGINS / MEDIA / WEBRTC **
          */
          /*
          2002: force WebRTC inside the proxy [FF70+] **
          */
          "media.peerconnection.ice.proxy_only_if_behind_proxy" = true;
          /*
            2003: force a single network interface for ICE candidates generation [FF42+]
          * When using a system-wide proxy, it uses the proxy interface
          * [1] https://developer.mozilla.org/en-US/docs/Web/API/RTCIceCandidate
          * [2] https://wiki.mozilla.org/Media/WebRTC/Privacy **
          */
          "media.peerconnection.ice.default_address_only" = true;
          /*
            2004: force exclusion of private IPs from ICE candidates [FF51+]
          * [SETUP-HARDEN] This will protect your private IP even in TRUSTED scenarios after you
          * grant device access, but often results in breakage on video-conferencing platforms **
          */
          "media.peerconnection.ice.no_host" = true;
          /*
            2020: disable GMP (Gecko Media Plugins)
          * [1] https://wiki.mozilla.org/GeckoMediaPlugins **
          */
          "media.gmp-provider.enabled" = false;

          /*
          ** [SECTION 2400]: DOM (DOCUMENT OBJECT MODEL) **
          */
          /*
          2402: prevent scripts from moving and resizing open windows **
          */
          "dom.disable_window_move_resize" = true;

          /*
          ** [SECTION 2600]: MISCELLANEOUS **
          */
          /*
            2601: prevent accessibility services from accessing your browser [RESTART]
          * [1] https://support.mozilla.org/kb/accessibility-services **
          */
          "accessibility.force_disabled" = 1;
          /*
            2603: remove temp files opened with an external application
          * [1] https://bugzilla.mozilla.org/302433 **
          */
          "browser.helperApps.deleteTempFileOnExit" = true;
          /*
          2606: disable UITour backend so there is no chance that a remote page can use it **
          */
          "browser.uitour.enabled" = false;
          "browser.uitour.url" = ""; ## Defense-in-depth
          /*
            2608: reset remote debugging to disabled
          * [1] https://gitlab.torproject.org/tpo/applications/tor-browser/-/issues/16222 **
          */
          "devtools.debugger.remote-enabled" = false; ## [DEFAULT: false]
          /*
            2616: remove special permissions for certain mozilla domains [FF35+]
          * [1] resource://app/defaults/permissions **
          */
          "permissions.manager.defaultsUrl" = "";
          /*
          2617: remove webchannel whitelist **
          */
          "webchannel.allowObject.urlWhitelist" = "";
          /*
            2619: use Punycode in Internationalized Domain Names to eliminate possible spoofing
          * [SETUP-WEB] Might be undesirable for non-latin alphabet users since legitimate IDN's are also punycoded
          * [TEST] https://www.xn--80ak6aa92e.com/ (www.apple.com)
          * [1] https://wiki.mozilla.org/IDN_Display_Algorithm
          * [2] https://en.wikipedia.org/wiki/IDN_homograph_attack
          * [3] https://cve.mitre.org/cgi-bin/cvekey.cgi?keyword=punycode+firefox
          * [4] https://www.xudongz.com/blog/2017/idn-phishing/ **
          */
          "network.IDN_show_punycode" = true;
          /*
            2620: enforce PDFJS, disable PDFJS scripting
          * This setting controls if the option "Display in Thunderbird" is available in the setting below
          *   and by effect controls whether PDFs are handled in-browser or externally ("Ask" or "Open With")
          * [WHY] pdfjs is lightweight, open source, and secure: the last exploit was June 2015 [1]
          *   It doesn't break "state separation" of browser content (by not sharing with OS, independent apps).
          *   It maintains disk avoidance and application data isolation. It's convenient. You can still save to disk.
          * NOTE: JS can still force a pdf to open in-browser by bundling its own code
          * [SETUP-CHROME] You may prefer a different pdf reader for security/workflow reasons
          * [SETTING] General > Files & Attachments > Portable Document Format (PDF)
          * [1] https://cve.mitre.org/cgi-bin/cvekey.cgi?keyword=pdf.js+firefox **
          */
          "pdfjs.disabled" = false; ## [DEFAULT: false]
          "pdfjs.enableScripting" = false; ## [FF86+]
          /*
            2623: disable permissions delegation [FF73+]
          * Currently applies to cross-origin geolocation, camera, mic and screen-sharing
          * permissions, and fullscreen requests. Disabling delegation means any prompts
          * for these will show/use their correct 3rd party origin
          * [1] https://groups.google.com/forum/#!topic/mozilla.dev.platform/BdFOMAuCGW8/discussion **
          */
          "permissions.delegation.enabled" = false;
          /*
          2624: disable middle click on new tab button opening URLs or searches using clipboard [FF115+]
          */
          "browser.tabs.searchclipboardfor.middleclick" = false; ## [DEFAULT: false NON-LINUX]

          /*
          * DOWNLOADS **
          */
          /*
            2651: enable user interaction for security by always asking where to download
          * [SETUP-CHROME] On Android this blocks longtapping and saving images **
          */
          "browser.download.useDownloadDir" = false;
          /*
          2653: disable adding downloads to the system's "recent documents" list **
          */
          "browser.download.manager.addToRecentDocs" = false;
          /*
          2654: enable user interaction for security by always asking how to handle new mimetypes [FF101+] **
          */
          "browser.download.always_ask_before_handling_new_types" = true;

          /*
          * EXTENSIONS **
          */
          /*
            2660: lock down allowed extension directories
          * [SETUP-CHROME] This will break extensions, language packs, themes and any other
          * XPI files which are installed outside of profile and application directories
          * [1] https://mike.kaply.com/2012/02/21/understanding-add-on-scopes/
          * [1] https://archive.is/DYjAM (archived) **
          */
          "extensions.enabledScopes" = 5; ## [HIDDEN PREF]
          "extensions.autoDisableScopes" = 15; ## [DEFAULT: 15]
          /*
            2662: disable webextension restrictions on certain mozilla domains (you also need 4503) [FF60+]
          * [1] https://bugzilla.mozilla.org/buglist.cgi?bug_id=1384330,1406795,1415644,1453988 **
          */
          "extensions.webextensions.restrictedDomains" = "";

          /*
          ** [SECTION 2700]: ETP (ENHANCED TRACKING PROTECTION) **
          */
          /*
            2702: disable ETP web compat features [FF93+]
          * [SETUP-HARDEN] Includes skip lists, heuristics (SmartBlock) and automatic grants
          * Opener and redirect heuristics are granted for 30 days, see [3]
          * [1] https://blog.mozilla.org/security/2021/07/13/smartblock-v2/
          * [2] https://hg.mozilla.org/mozilla-central/rev/e5483fd469ab#l4.12
          * [3] https://developer.mozilla.org/en-US/docs/Web/Privacy/State_Partitioning#storage_access_heuristics **
          */
          "privacy.antitracking.enableWebcompat" = false;
          /*
          2710: enable state partitioning of service workers [FF96+] **
          */
          "privacy.partition.serviceWorkers" = true; ## [DEFAULT: true FF105+]
          /*
          2720: enable APS (Always Partitioning Storage) **
          */
          "privacy.partition.always_partition_third_party_non_cookie_storage" = true; ## [FF104+] [DEFAULT: true FF109+]
          "privacy.partition.always_partition_third_party_non_cookie_storage.exempt_sessionstorage" = false; ## [FF105+] [DEFAULT: false FF109+]

          /*
          ** [SECTION 2800]: SHUTDOWN & SANITIZING **
          */
          /*
          2810: enable Thunderbird to clear items on shutdown **
          */
          "privacy.sanitize.sanitizeOnShutdown" = true;

          /*
          * SANITIZE ON SHUTDOWN: IGNORES "ALLOW" SITE EXCEPTIONS **
          */
          /*
            2811: set/enforce what items to clear on shutdown (if 2810 is true) [SETUP-CHROME]
          * NOTE: If "history" is true, downloads will also be cleared
          * NOTE: "sessions": Active Logins: refers to HTTP Basic Authentication [1], not logins via cookies
          * [1] https://en.wikipedia.org/wiki/Basic_access_authentication **
          */
          "privacy.clearOnShutdown.cache" = true; ## [DEFAULT: true]
          "privacy.clearOnShutdown.downloads" = true; ## [DEFAULT: true]
          "privacy.clearOnShutdown.formdata" = true; ## [DEFAULT: true]
          "privacy.clearOnShutdown.history" = true; ## [DEFAULT: true]
          "privacy.clearOnShutdown.sessions" = false; ## [DEFAULT: true]
          "privacy.clearOnShutdown.siteSettings" = false; ## [DEFAULT: false]
          /*
            2812: set Session Restore to clear on shutdown (if 2810 is true) [FF34+]
          * NOTE: Not needed if Session Restore is not used (0102) or it is already cleared with history (2811)
          * NOTE: If true, this prevents resuming from crashes (also see 5008) **
          */
          "privacy.clearOnShutdown.openWindows" = true;

          /*
          * SANITIZE ON SHUTDOWN: RESPECTS "ALLOW" SITE EXCEPTIONS FF103+ **
          */
          /*
            2815: set "Cookies" and "Site Data" to clear on shutdown (if 2810 is true) [SETUP-CHROME]
          * NOTE: Exceptions: A "cookie" block permission also controls "offlineApps" (see note below).
          * serviceWorkers require an "Allow" permission. For cross-domain logins, add exceptions for
          * both sites e.g. https://www.youtube.com (site) + https://accounts.google.com (single sign on)
          * NOTE: "offlineApps": Offline Website Data: localStorage, service worker cache, QuotaManager (IndexedDB, asm-cache)
          * [WARNING] Be selective with what sites you "Allow", as they also disable partitioning (1767271)
          * [SETTING] to add site exceptions: Ctrl+I>Permissions>Cookies>Allow (when on the website in question)
          * [SETTING] to manage site exceptions: Options>Privacy & Security>Permissions>Settings **
          */
          "privacy.clearOnShutdown.cookies" = false; ## Cookies
          "privacy.clearOnShutdown.offlineApps" = false; ## Site Data

          /*
          * SANITIZE MANUAL: IGNORES "ALLOW" SITE EXCEPTIONS **
          */
          /*
            2820: reset default items to clear with Ctrl-Shift-Del [SETUP-CHROME]
          * This dialog can also be accessed from the menu History>Clear Recent History
          * Thunderbird remembers your last choices. This will reset them when you start Thunderbird
          * NOTE: Regardless of what you set "downloads" to, as soon as the dialog
          * for "Clear Recent History" is opened, it is synced to the same as "history" **
          */
          "privacy.cpd.cache" = true; ## [DEFAULT: true]
          "privacy.cpd.formdata" = true; ## [DEFAULT: true]
          "privacy.cpd.history" = true; ## [DEFAULT: true]
          "privacy.cpd.sessions" = true; ## [DEFAULT: true]
          "privacy.cpd.offlineApps" = true; ## [DEFAULT: false]
          "privacy.cpd.cookies" = true;
          "privacy.cpd.downloads" = true; ## not used, see note above
          "privacy.cpd.openWindows" = false; ## Session Restore
          "privacy.cpd.passwords" = false;
          "privacy.cpd.siteSettings" = false;
          /*
            2822: reset default "Time range to clear" for "Clear Recent History" (2820)
          * Thunderbird remembers your last choice. This will reset the value when you start Thunderbird
          * 0=everything, 1=last hour, 2=last two hours, 3=last four hours, 4=today
          * NOTE: Values 5 (last 5 minutes) and 6 (last 24 hours) are not listed in the dropdown,
          * which will display a blank value, and are not guaranteed to work **
          */
          "privacy.sanitize.timeSpan" = 0;

          /*
            ** [SECTION 4500]: RFP (RESIST FINGERPRINTING)
             RFP covers a wide range of ongoing fingerprinting solutions.
             It is an all-or-nothing buy in: you cannot pick and choose what parts you want
             [TEST] https://arkenfox.github.io/TZP/tzp.html

             [WARNING] DO NOT USE extensions to alter RFP protected metrics

              418986 - limit window.screen & CSS media queries (FF41)
             1281949 - spoof screen orientation (FF50)
             1330890 - spoof timezone as UTC0 (FF55)
             1360039 - spoof navigator.hardwareConcurrency as 2 (FF55)
             1217238 - reduce precision of time exposed by javascript (FF55)
           FF56
             1369303 - spoof/disable performance API
             1333651 - spoof User Agent & Navigator API
                version: android version spoofed as ESR
                OS: JS spoofed as Windows 10, OS 10.15, Android 10, or Linux | HTTP Headers spoofed as Windows or Android
             1369319 - disable device sensor API
             1369357 - disable site specific zoom
             1337161 - hide gamepads from content
             1372072 - spoof network information API as "unknown" when dom.netinfo.enabled = true
             1333641 - reduce fingerprinting in WebSpeech API
           FF57
             1369309 - spoof media statistics
             1382499 - reduce screen co-ordinate fingerprinting in Touch API
             1217290 & 1409677 - enable some fingerprinting resistance for WebGL
             1382545 - reduce fingerprinting in Animation API
             1354633 - limit MediaError.message to a whitelist
           FF58+
             1372073 - spoof/block fingerprinting in MediaDevices API (FF59)
                Spoof: enumerate devices as one "Internal Camera" and one "Internal Microphone"
                Block: suppresses the ondevicechange event
             1039069 - warn when language prefs are not set to "en*" (also see 0210, 0211) (FF59)
             1222285 & 1433592 - spoof keyboard events and suppress keyboard modifier events (FF59)
                Spoofing mimics the content language of the document. Currently it only supports en-US.
                Modifier events suppressed are SHIFT and both ALT keys. Chrome is not affected.
             1337157 - disable WebGL debug renderer info (FF60)
             1459089 - disable OS locale in HTTP Accept-Language headers (ANDROID) (FF62)
             1479239 - return "no-preference" with prefers-reduced-motion (FF63)
             1363508 - spoof/suppress Pointer Events (FF64)
             1492766 - spoof pointerEvent.pointerid (FF65)
             1485266 - disable exposure of system colors to CSS or canvas (FF67)
             1494034 - return "light" with prefers-color-scheme (FF67)
             1564422 - spoof audioContext outputLatency (FF70)
             1595823 - return audioContext sampleRate as 44100 (FF72)
             1607316 - spoof pointer as coarse and hover as none (ANDROID) (FF74)
             1621433 - randomize canvas (previously FF58+ returned an all-white canvas) (FF78)
             1506364 - return "no-preference" with prefers-contrast (FF80)
             1653987 - limit font visibility to bundled and "Base Fonts" (Windows, Mac, some Linux) (FF80)
             1461454 - spoof smooth=true and powerEfficient=false for supported media in MediaCapabilities (FF82)
              531915 - use fdlibm's sin, cos and tan in jsmath (FF93, ESR91.1)
             1756280 - enforce navigator.pdfViewerEnabled as true and plugins/mimeTypes as hard-coded values (FF100)
             1692609 - reduce JS timing precision to 16.67ms (previously FF55+ was 100ms) (FF102)
             1422237 - return "srgb" with color-gamut (FF110)
             1794628 - return "none" with inverted-colors (FF114)
          **
          */
          /*
            4501: enable privacy.resistFingerprinting
          * [SETUP-WEB] RFP can cause some website breakage: mainly canvas, use a site exception via the urlbar
          * RFP also has a few side effects: mainly timezone is UTC0, and websites will prefer light theme
          * NOTE: pbmode applies if true and the original pref is false
          * [1] https://bugzilla.mozilla.org/418986 **
          */
          "privacy.resistFingerprinting" = true; ## [FF41+]
          "privacy.resistFingerprinting.pbmode" = true; ## [FF114+]
          /*
            4502: set new window size rounding max values [FF55+]
          * [SETUP-CHROME] sizes round down in hundreds: width to 200s and height to 100s, to fit your screen
          * [1] https://bugzilla.mozilla.org/1330882 **
          */
          "privacy.window.maxInnerWidth" = 1600;
          "privacy.window.maxInnerHeight" = 900;
          /*
            4503: disable mozAddonManager Web API [FF57+]
          * NOTE: To allow extensions to work on AMO, you also need 2662 and 4505
          * [1] https://bugzilla.mozilla.org/buglist.cgi?bug_id=1384330,1406795,1415644,1453988 **
          */
          "privacy.resistFingerprinting.block_mozAddonManager" = true; ## [HIDDEN PREF FF57-108]
          /*
            4504: enable RFP letterboxing [FF67+]
          * Dynamically resizes the inner window by applying margins in stepped ranges [2]
          * If you use the dimension pref, then it will only apply those resolutions.
          * The format is "width1xheight1, width2xheight2, ..." (e.g. "800x600, 1000x1000")
          * [SETUP-WEB] This is independent of RFP (4501). If you're not using RFP, or you are but
          * dislike the margins, then flip this pref, keeping in mind that it is effectively fingerprintable
          * [WARNING] DO NOT USE: the dimension pref is only meant for testing
          * [1] https://bugzilla.mozilla.org/1407366
          * [2] https://hg.mozilla.org/mozilla-central/rev/6d2d7856e468#l2.32 **
          */
          "privacy.resistFingerprinting.letterboxing" = true; ## [HIDDEN PREF]
          "privacy.resistFingerprinting.letterboxing.dimensions" = ""; ## [HIDDEN PREF]
          /*
            4505: experimental RFP [FF91+]
          * List of domains exempted from RFP (comma-separated).
          * [WARNING] DO NOT USE unless testing, see [1] comment 12
          * [1] https://bugzilla.mozilla.org/1635603 **
          */
          "privacy.resistFingerprinting.exemptedDomains" = "addons.thunderbird.net";
          /*
          4506: set RFP's font visibility level (1402) [FF94+] **
          */
          "layout.css.font-visibility.resistFingerprinting" = 1; ## [DEFAULT: 1]
          /*
            4510: disable using system colors
          * [SETTING] General > Language and Appearance > Fonts and Colors > Colors... > Use system colors **
          */
          "browser.display.use_system_colors" = false; ## [DEFAULT: false NON-WINDOWS]
          /*
            4511: enforce non-native widget theme
          * Security: removes/reduces system API calls, e.g. win32k API [1]
          * Fingerprinting: provides a uniform look and feel across platforms [2]
          * [1] https://bugzilla.mozilla.org/1381938
          * [2] https://bugzilla.mozilla.org/1411425 **
          */
          "widget.non-native-theme.enabled" = true; ## [DEFAULT: true]
          /*
            4512: enforce links targeting new windows to open in a new tab instead
          * 1=most recent window or tab, 2=new window, 3=new tab
          * Stops malicious window sizes and some screen resolution leaks.
          * You can still right-click a link and open in a new window
          * NOTE: Thunderbird only supports 3 (see [2])
          * [TEST] https://arkenfox.github.io/TZP/tzp.html#screen
          * [1] https://gitlab.torproject.org/tpo/applications/tor-browser/-/issues/9881
          * [2] https://searchfox.org/comm-esr102/source/mail/app/profile/all-thunderbird.js#721 **
          */
          "browser.link.open_newwindow" = 3; ## [DEFAULT: 3]
          /*
            4513: set all open window methods to abide by "browser.link.open_newwindow" (4512)
          * NOTE: Thunderbird only supports 0 (see [2])
          * [1] https://searchfox.org/mozilla-central/source/dom/tests/browser/browser_test_new_window_from_content.js
          * [2] https://searchfox.org/comm-esr102/source/mail/app/profile/all-thunderbird.js#730 **
          */
          "browser.link.open_newwindow.restriction" = 0;
          /*
            4520: disable WebGL (Web Graphics Library)
          * [SETUP-WEB] If you need it then override it. RFP still randomizes canvas for naive scripts **
          */
          "webgl.disabled" = true;

          /*
            ** [SECTION 5000]: OPTIONAL OPSEC
             Disk avoidance, application data isolation, eyeballs...
          **
          */
          /*
            5001: start Thunderbird in PB (Private Browsing) mode
          * NOTE: In this mode all windows are "private windows" and the PB mode icon is not displayed
          * NOTE: The P in PB mode can be misleading: it means no "persistent" disk state such as history,
          * caches, searches, cookies, localStorage, IndexedDB etc (which you can achieve in normal mode).
          * In fact, PB mode limits or removes the ability to control some of these, and you need to quit
          * Thunderbird to clear them. PB is best used as a one off window (Menu>New Private Window) to provide
          * a temporary self-contained new session. Close all private windows to clear the PB session.
          * [1] https://wiki.mozilla.org/Private_Browsing
          * [2] https://support.mozilla.org/kb/common-myths-about-private-browsing **
          */
          "browser.privatebrowsing.autostart" = true;
          /*
            5002: disable memory cache
          * capacity: -1=determine dynamically (default), 0=none, n=memory capacity in kibibytes **
          */
          "browser.cache.memory.enable" = false;
          "browser.cache.memory.capacity" = 0;
          /*
            5003: disable saving passwords
          * NOTE: This does not clear any already saved passwords and will make TB ask for it every time **
          */
          "signon.rememberSignons" = false;
          /*
            5004: disable permissions manager from reading or writing to disk [FF41+] [RESTART]
          * [SETUP-CHROME] This means any permission changes (cookie or mail remote content) are session only
          * [1] https://bugzilla.mozilla.org/967812 **
          */
          "permissions.memory_only" = true; ## [HIDDEN PREF]
          /*
            5005: disable intermediate certificate caching [FF41+] [RESTART]
          * NOTE: This affects login/cert/key dbs. The effect is all credentials are session-only.
          * Saved logins and passwords are not available. Reset the pref and restart to return them **
          */
          # "security.nocertdb" = true;
          /*
            5006: disable favicons in history and bookmarks
          * NOTE: Stored as data blobs in favicons.sqlite, these don't reveal anything that your
          * actual history (and bookmarks) already do. Your history is more detailed, so
          * control that instead; e.g. disable history, clear history on exit, use PB mode
          * NOTE: favicons.sqlite is sanitized on Thunderbird close **
          */
          "browser.chrome.site_icons" = false;
          /*
          5007: exclude "Undo Closed Tabs" in Session Restore **
          */
          "browser.sessionstore.max_tabs_undo" = 0;
          /*
            5008: disable resuming session from crash
          * [TEST] about:crashparent **
          */
          "browser.sessionstore.resume_from_crash" = false;
          /*
            5009: disable "open with" in download dialog [FF50+]
          * Application data isolation [1]
          * [1] https://bugzilla.mozilla.org/1281959 **
          */
          "browser.download.forbid_open_with" = true;
          /*
            5013: disable browsing and download history
          * NOTE: We also clear history and downloads on exit (2811) **
          */
          "places.history.enabled" = false;
          /*
            5016: discourage downloading to desktop
          * 0=desktop, 1=downloads (default), 2=custom **
          */
          "browser.download.folderList" = 2;
          /*
            5017: disable Form Autofill
          * If .supportedCountries includes your region (browser.search.region) and .supported
          * is "detect" (default), then the UI will show. Stored data is not secure, uses JSON
          * [1] https://wiki.mozilla.org/Firefox/Features/Form_Autofill **
          */
          "extensions.formautofill.addresses.enabled" = false; ## [FF55+]
          "extensions.formautofill.creditCards.enabled" = false; ## [FF56+]
          /*
          5018: limit events that can cause a pop-up **
          */
          "dom.popup_allowed_events" = "click dblclick mousedown pointerdown";
          /*
          5019: disable page thumbnail collection **
          */
          "browser.pagethumbnails.capturing_disabled" = true; ## [HIDDEN PREF]
          /*
          5020: disable Windows native notifications and use app notications instead [FF111+] [WINDOWS] **
          */
          "alerts.useSystemBackend.windows.notificationserver.enabled" = false;
          /*
            5901: Enforce Private Browsing for OAuth sign-in
          * Providers may expect a device identifier from the browser, which could cause issues with PB. As
          * many users could suffer from this we keep this it disabled, feel free to switch it on if yours
          * supports it.
          */
          # "mailnews.oauth.usePrivateBrowser" = false;

          /*
            ** [SECTION 5500]: OPTIONAL HARDENING
             Thunderbird-User.JS maintainer here :
                  Whereas not recommended by upstream arkenfox, we disable each one of those Web
                  features as we focus on keeping Thunderbird an email client and not a browser.
          **
          */
          /*
            5501: disable MathML (Mathematical Markup Language) [FF51+]
          * [1] https://cve.mitre.org/cgi-bin/cvekey.cgi?keyword=mathml **
          */
          "mathml.disabled" = true; ## 1173199
          /*
            5502: disable in-content SVG (Scalable Vector Graphics) [FF53+]
          * [1] https://cve.mitre.org/cgi-bin/cvekey.cgi?keyword=firefox+svg **
          */
          "svg.disabled" = true; ## 1216893
          /*
            5503: disable graphite
          * [1] https://cve.mitre.org/cgi-bin/cvekey.cgi?keyword=firefox+graphite
          * [2] https://en.wikipedia.org/wiki/Graphite_(SIL) **
          */
          "gfx.font_rendering.graphite.enabled" = false;
          /*
            5504: disable asm.js [FF22+]
          * [1] http://asmjs.org/
          * [2] https://cve.mitre.org/cgi-bin/cvekey.cgi?keyword=asm.js
          * [3] https://rh0dev.github.io/blog/2017/the-return-of-the-jit/ **
          */
          "javascript.options.asmjs" = false;
          /*
            5505: disable Ion and baseline JIT to harden against JS exploits
          * NOTE: When both Ion and JIT are disabled, and trustedprincipals
          * is enabled, then Ion can still be used by extensions (1599226)
          * [1] https://cve.mitre.org/cgi-bin/cvekey.cgi?keyword=firefox+jit
          * [2] https://microsoftedge.github.io/edgevr/posts/Super-Duper-Secure-Mode/ **
          */
          "javascript.options.ion" = false;
          "javascript.options.baselinejit" = false;
          "javascript.options.jit_trustedprincipals" = true; ## [FF75+] [HIDDEN PREF]
          /*
            5506: disable WebAssembly [FF52+]
          * Vulnerabilities [1] have increasingly been found, including those known and fixed
          * in native programs years ago [2]. WASM has powerful low-level access, making
          * certain attacks (brute-force) and vulnerabilities more possible
          * [STATS] ~0.2% of websites, about half of which are for crytomining / malvertising [2][3]
          * [1] https://cve.mitre.org/cgi-bin/cvekey.cgi?keyword=wasm
          * [2] https://spectrum.ieee.org/tech-talk/telecom/security/more-worries-over-the-security-of-web-assembly
          * [3] https://www.zdnet.com/article/half-of-the-websites-using-webassembly-use-it-for-malicious-purposes **
          */
          "javascript.options.wasm" = false;
          /*
          5507: disable rendering of SVG OpenType fonts **
          */
          "gfx.font_rendering.opentype_svg.enabled" = false;
          /*
            5508: disable all DRM content (EME: Encryption Media Extension)
          * Optionally hide the UI setting which also disables the DRM prompt
          * [TEST] https://bitmovin.com/demos/drm
          * [1] https://www.eff.org/deeplinks/2017/10/drms-dead-canary-how-we-just-lost-web-what-we-learned-it-and-what-we-need-do-next **
          */
          "media.eme.enabled" = false;
          "browser.eme.ui.enabled" = false;
          /*
            5509: disable IPv6 if using a VPN
          * This is an application level fallback. Disabling IPv6 is best done at an OS/network
          * level, and/or configured properly in system wide VPN setups.
          * If you see PR_CONNECT_RESET_ERROR, this pref *might* be the cause
          * NOTE: PHP defaults to IPv6 with "localhost". Use "php -S 127.0.0.1:PORT"
          * [TEST] https://ipleak.org/
          * [1] https://www.internetsociety.org/tag/ipv6-security/ (Myths 2,4,5,6) **
          */
          "network.dns.disableIPv6" = true;
          /*
            5510: control when to send a cross-origin referer
          * 0=always (default), 1=only if base domains match, 2=only if hosts match
          * NOTE: Will cause breakage: older modems/routers and some sites e.g banks, vimeo, icloud, instagram **
          */
          "network.http.referer.XOriginPolicy" = 2;
          /*
          5590: show a prompt when opening a link in external applications **
          */
          "security.external_protocol_requires_permission" = true;

          /*
          ** [SECTION 6000]: DON'T TOUCH **
          */
          /*
            6001: enforce Mozilla's blocklist
          * [WHY] It includes updates for "revoked certificates"
          * [1] https://blog.mozilla.org/security/2015/03/03/revoking-intermediate-certificates-introducing-onecrl/ **
          */
          "extensions.blocklist.enabled" = true; ## [DEFAULT: true]
          /*
            6002: enforce no referer spoofing
          * [WHY] Spoofing can affect CSRF (Cross-Site Request Forgery) protections **
          */
          "network.http.referer.spoofSource" = false; ## [DEFAULT: false]
          /*
            6004: enforce a security delay on some confirmation dialogs such as install, open/save
          * [1] https://www.squarefree.com/2004/07/01/race-conditions-in-security-dialogs/ **
          */
          "security.dialog_enable_delay" = 1000; ## [DEFAULT: 1000]
          /*
            6008: enforce no First Party Isolation [FF51+]
          * [WARNING] Replaced with network partitioning (FF85+) and TCP (2701), and enabling FPI
          * disables those. FPI is no longer maintained except at Tor Project for Tor Browser's config **
          */
          "privacy.firstparty.isolate" = false; ## [DEFAULT: false]
          /*
            6009: enforce SmartBlock shims [FF81+]
          * In FF96+ these are listed in about:compat
          * [1] https://blog.mozilla.org/security/2021/03/23/introducing-smartblock/ **
          */
          "extensions.webcompat.enable_shims" = true; ## [DEFAULT: true]
          /*
            6010: enforce no TLS 1.0/1.1 downgrades
          * [TEST] https://tls-v1-1.badssl.com:1010/ **
          */
          "security.tls.version.enable-deprecated" = false; ## [DEFAULT: false]
          /*
            6011: enforce disabling of Web Compatibility Reporter [FF56+]
          * Web Compatibility Reporter adds a "Report Site Issue" button to send data to Mozilla
          * [WHY] To prevent wasting Mozilla's time with a custom setup **
          */
          "extensions.webcompat-reporter.enabled" = false; ## [DEFAULT: false]
          /*
            6012: enforce Quarantined Domains [FF115+]
          * [WHY] https://support.mozilla.org/kb/quarantined-domains
          */
          "extensions.quarantinedDomains.enabled" = true; ## [DEFAULT: true]
          /*
          6050: prefsCleaner: reset previously active items removed from arkenfox FF102+ **
          */
          "beacon.enabled" = "";
          "browser.region.network.url" = "";
          "browser.region.update.enabled" = "";
          "browser.ssl_override_behavior" = "";
          "devtools.chrome.enabled" = "";
          "dom.disable_beforeunload" = "";
          "dom.disable_open_during_load" = "";
          "extensions.formautofill.available" = "";
          "extensions.formautofill.addresses.supported" = "";
          "extensions.formautofill.creditCards.available" = "";
          "extensions.formautofill.creditCards.supported" = "";
          "middlemouse.contentLoadURL" = "";
          /*
          6051: prefsCleaner: reset previously active items removed from arkenfox FF115+ **
          */
          "network.protocol-handler.external.ms-windows-store" = "";

          /*
            ** [SECTION 7000]: DON'T BOTHER
             Thunderbird-User.JS maintainer here :
                  Actually we do, TB is an e-mail client, not a (bloated) browser.
                  Thus some of below preferences have been set, despite upstream (Arkenfox) warnings.
          **
          */
          /*
            7001: disable APIs
          * Location-Aware Browsing, Full Screen
          * [WHY] The API state is easily fingerprintable.
          * Geo is behind a prompt (7002). Full screen requires user interaction **
          */
          "geo.enabled" = false;
          "full-screen-api.enabled" = false;
          /*
            7003: disable non-modern cipher suites [1]
          * [WHY] Passive fingerprinting. Minimal/non-existent threat of downgrade attacks
          * [1] https://browserleaks.com/ssl **
          */
          "security.ssl3.ecdhe_ecdsa_aes_256_sha" = false; ## [DEFAULT: false FF109+]
          "security.ssl3.ecdhe_ecdsa_aes_128_sha" = false; ## [DEFAULT: false FF109+]
          "security.ssl3.ecdhe_rsa_aes_128_sha" = false;
          "security.ssl3.ecdhe_rsa_aes_256_sha" = false;
          "security.ssl3.rsa_aes_128_gcm_sha256" = false; ## no PFS
          "security.ssl3.rsa_aes_256_gcm_sha384" = false; ## no PFS
          "security.ssl3.rsa_aes_128_sha" = false; ## no PFS
          "security.ssl3.rsa_aes_256_sha" = false; ## no PFS
          /*
            7004: control TLS versions
          * [WHY] Passive fingerprinting and security **
          */
          "security.tls.version.min" = 3; ## [DEFAULT: 3]
          "security.tls.version.max" = 4;
          /*
            7005: disable SSL session IDs [FF36+]
          * [WHY] Passive fingerprinting and perf costs. These are session-only
          * and isolated with network partitioning (FF85+) and/or containers **
          */
          "security.ssl.disable_session_identifiers" = true;
          /*
            7006: onions
          * [WHY] Thunderbird doesn't support hidden services. Use Tor Browser **
          */
          "dom.securecontext.allowlist_onions" = true; ## [FF97+] 1382359/1744006
          "network.http.referer.hideOnionSource" = true; ## 1305144
          /*
            7007: referers
          * [WHY] Only cross-origin referers (1602, 5510) matter **
          */
          "network.http.sendRefererHeader" = 0;
          "network.http.referer.trimmingPolicy" = 0;
          /*
            7008: set the default Referrer Policy [FF59+]
          * 0=no-referer, 1=same-origin, 2=strict-origin-when-cross-origin, 3=no-referrer-when-downgrade
          * [WHY] Defaults are fine. They can be overridden by a site-controlled Referrer Policy **
          */
          "network.http.referer.defaultPolicy" = 0; ## [DEFAULT: 2]
          "network.http.referer.defaultPolicy.pbmode" = 0; ## [DEFAULT: 2]
          /*
            7010: disable HTTP Alternative Services [FF37+]
          * [WHY] Already isolated with network partitioning (FF85+) **
          */
          "network.http.altsvc.enabled" = false;
          /*
            7011: disable website control over browser right-click context menu
          * [WHY] Just use Shift-Right-Click **
          */
          "dom.event.contextmenu.enabled" = false;
          /*
            7012: disable icon fonts (glyphs) and local fallback rendering
          * [WHY] Breakage, font fallback is equivalency, also RFP
          * [1] https://bugzilla.mozilla.org/789788
          * [2] https://gitlab.torproject.org/legacy/trac/-/issues/8455 **
          */
          "gfx.downloadable_fonts.enabled" = false; ## [FF41+]
          "gfx.downloadable_fonts.fallback_delay" = -1;
          /*
            7013: disable Clipboard API
          * [WHY] Fingerprintable. Breakage. Cut/copy/paste require user
          * interaction, and paste is limited to focused editable fields **
          */
          "dom.event.clipboardevents.enabled" = false;
          /*
            7014: disable System Add-on updates
          * [WHY] It can compromise security. System addons ship with prefs, use those **
          */
          "extensions.systemAddon.update.enabled" = false; ## [FF62+]
          "extensions.systemAddon.update.url" = ""; ## [FF44+]
          /*
            7015: enable the DNT (Do Not Track) HTTP header
          * [WHY] DNT is enforced with Tracking Protection which is used in ETP Strict (2701) **
          */
          "privacy.donottrackheader.enabled" = true;
          /*
            7016: customize ETP settings
          * [WHY] Arkenfox only supports strict (2701) which sets these at runtime **
          */
          "network.cookie.cookieBehavior" = 5; ## [DEFAULT: 5 FF103+]
          "network.http.referer.disallowCrossSiteRelaxingDefault" = true;
          "network.http.referer.disallowCrossSiteRelaxingDefault.top_navigation" = true; ## [FF100+]
          "privacy.partition.network_state.ocsp_cache" = true;
          "privacy.query_stripping.enabled" = true; ## [FF101+] [ETP FF102+]
          "privacy.trackingprotection.enabled" = true;
          "privacy.trackingprotection.socialtracking.enabled" = true;
          "privacy.trackingprotection.cryptomining.enabled" = true; ## [DEFAULT: true]
          "privacy.trackingprotection.fingerprinting.enabled" = true; ## [DEFAULT: true]
          /*
            7017: disable service workers
          * [WHY] Already isolated with TCP (2701) behind a pref (2710) **
          */
          "dom.serviceWorkers.enabled" = false;
          /*
            7018: disable Web Notifications
          * [WHY] Web Notifications are behind a prompt (7002)
          * [1] https://blog.mozilla.org/en/products/firefox/block-notification-requests/ **
          */
          "dom.webnotifications.enabled" = false; ## [FF22+]
          "dom.webnotifications.serviceworker.enabled" = false; ## [FF44+]
          /*
            7019: disable Push Notifications [FF44+]
          * [WHY] Push requires subscription
          * NOTE: To remove all subscriptions, reset "dom.push.userAgentID"
          * [1] https://support.mozilla.org/kb/push-notifications-firefox **
          */
          "dom.push.enabled" = false;
          /*
            7020: disable WebRTC (Web Real-Time Communication)
          * [WHY] Firefox desktop uses mDNS hostname obfuscation and the private IP is never exposed until
          * required in TRUSTED scenarios; i.e. after you grant device (microphone or camera) access
          * [TEST] https://browserleaks.com/webrtc
          * [1] https://groups.google.com/g/discuss-webrtc/c/6stQXi72BEU/m/2FwZd24UAQAJ
          * [2] https://datatracker.ietf.org/doc/html/draft-ietf-mmusic-mdns-ice-candidates#section-3.1.1 **
          */
          "media.peerconnection.enabled" = false;

          /*
            ** [SECTION 8000]: DON'T BOTHER: FINGERPRINTING
             [WHY] They are insufficient to help anti-fingerprinting and do more harm than good
             [WARNING] DO NOT USE with RFP. RFP already covers these and they can interfere
             NOTE: An empty User-Agent may break Microsoft Exchange OAuth2 login
          **
          */
          /*
          8001: prefsCleaner: reset items useless for anti-fingerprinting **
          */
          "browser.display.use_document_fonts" = "";
          "browser.zoom.siteSpecific" = "";
          "device.sensors.enabled" = "";
          "dom.enable_performance" = "";
          "dom.enable_resource_timing" = "";
          "dom.gamepad.enabled" = "";
          "dom.maxHardwareConcurrency" = "";
          "dom.w3c_touch_events.enabled" = "";
          "dom.webaudio.enabled" = "";
          "font.system.whitelist" = "";
          "general.appname.override" = "";
          "general.appversion.override" = "";
          "general.buildID.override" = "";
          "general.oscpu.override" = "";
          "general.platform.override" = "";
          "general.useragent.override" = "";
          "media.navigator.enabled" = "";
          "media.ondevicechange.enabled" = "";
          "media.video_stats.enabled" = "";
          "media.webspeech.synth.enabled" = "";
          "ui.use_standins_for_native_colors" = "";
          "webgl.enable-debug-renderer-info" = "";

          /*
          ** [SECTION 9000]: NON-PROJECT RELATED **
          */
          /*
          9001: disable welcome notices **
          */
          "browser.startup.homepage_override.mstone" = "ignore";
          /*
          9090: disable return receipt sending unconditionally **
          */
          "mail.mdn.report.enabled" = false;
          /*
          9099: e-mail custom headers (examples) **
          */
          "mail.compose.other.header" = "X-Custom-Header,X-Another-Custom-Header"; ## corresponding values can be set in compose window ("double-arrow" drop-down
          "mail.identity.id1.headers" = "References, InReplyTo";
          "mail.identity.id1.header.References" = "References: <2ad46d80-c8ce-49a3-9896-16171788ac28@example.tld>\n <31ff00c2-b7cb-4063-beeb-a0bdd424c3a7@example1.tld>";
          "mail.identity.id1.header.InReplyTo" = "In-Reply-To: <31ff00c2-b7cb-4063-beeb-a0bdd424c3a7@example1.tld>";

          /*
            ** [SECTION 9100]: THUNDERBIRD (AUTO CONFIG / UI / HEADERS / ADDRESS BOOK)
             Options general to Thunderbird's mail configuration and user interface

             [1] https://searchfox.org/comm-esr91/source/
             [2] http://kb.mozillazine.org/Mail_and_news_settings
          **
          */

          /*
          * AUTO CONFIG **
          */
          /*
            9101: Disable auto-configuration [SETUP-INSTALL]
          * These options disable auto-configuration of mail servers in Thunderbird.
          * Such settings require a query to Mozilla which could have privacy implications
          * if the user wishes to keep the existence of the mail provider private.
          * We also enforce (valid) SSL/TLS connections if auto-configuration happens to be enabled.
          * If auto-configuration is re-enabled, fetching from Exchange will be allowed by default.
          * [1] https://developer.mozilla.org/en-US/docs/Mozilla/Thunderbird/Autoconfiguration **
          */
          "mailnews.auto_config.guess.enabled" = true;
          "mailnews.auto_config.fetchFromISP.enabled" = true;
          "mailnews.auto_config.fetchFromISP.sendEmailAddress" = true;
          "mailnews.auto_config.fetchFromISP.sslOnly" = true;
          # "mailnews.auto_config.fetchFromExchange.enabled" = false;
          "mailnews.auto_config.guess.sslOnly" = true;
          "mailnews.auto_config.guess.requireGoodCert" = true; ## [DEFAULT: true]
          "mailnews.auto_config_url" = "https://live.thunderbird.net/autoconfig/v1.1/";
          "mailnews.auto_config.addons_url" = "https://live.thunderbird.net/autoconfig/addons.json";
          /*
            9102: Disable account provisioning [SETUP-INSTALL]
          * This option allows users to create a new email account through partner providers.
          * [1] https://developer.mozilla.org/en-US/docs/Mozilla/Thunderbird/Account_Provisioner **
          */
          "mail.provider.enabled" = false;

          /*
          * UI (User Interface) **
          */
          /*
            9111: Show full email instead of just name from address book
          * true=Show just the display name for people in the address book (default)
          * false=Show both the email address and display name. **
          */
          "mail.showCondensedAddresses" = false;
          /*
            9112: Disable "Filelink for Large Attachments" feature
          * [1] https://support.thunderbird.net/kb/filelink-large-attachments **
          */
          "mail.cloud_files.enabled" = false;
          /*
          9113: Don't hide cookies and passwords related (advanced?) buttons **
          */
          "pref.privacy.disable_button.view_cookies" = false;
          "pref.privacy.disable_button.cookie_exceptions" = false;
          "pref.privacy.disable_button.view_passwords" = false;

          /*
          * HEADERS **
          */
          /*
            9120:
          * true=Show Sender header in message pane.
          * false=Does nothing. (default) **
          */
          "mailnews.headers.showSender" = true;
          /*
            9121:
          * true=Show User Agent header in message pane
          * false=Does nothing. (default) **
          */
          "mailnews.headers.showUserAgent" = false;
          /*
            9122: Hello argument
          * Lets you replace your IP address with the specified string in Received: headers when your
          * IP address is not a "fully qualified domain name" (FQDN). Typically you only need to do this
          * when you have a NAT box to prevent it from using the NAT boxes IP address.
          * If you don't set it to something in your SMTP server's domain it may increase your spam
          * score. **
          */
          "mail.smtpserver.default.hello_argument" = "[127.0.0.1]";
          /*
            9123: Displayed dates and times
          * [SETUP-INSTALL] When your e-mail program displays the e-mail's date and time, it normally
          * converts them to your time zone. If your computer's time zone settings are wrong, then you will
          * see the wrong time (and possibly the wrong date).
          * To turn this conversion off, you can use a preference setting.
          * It affects the headers that you see in e-mails that you open or preview, but it does not affect
          * the Date column in folders.
          * [1] http://kb.mozillazine.org/Time_and_time_zone_settings
          * [2] http://wiki.cacert.org/ThunderBirdAdvancedConfig
          * **
          */
          "mailnews.display.original_date" = false;
          /*
          9124: Display the sender's Timezone when set to true **
          */
          "mailnews.display.date_senders_timezone" = false;
          /*
            9125: Display Time Date based on Received Header
          * Thunderbird shows the time when the message was sent, according to the sender. It is possible
          * to make Thunderbird show the time when the message arrived on your mail server, based on the
          * "Received" header. Set the following preference. New messages will show the time the message
          * was received, rather than when it was sent. **
          */
          "mailnews.use_received_date" = true;
          /*
          9126: Send minimal User-Agent in outgoing email messages (default)
          */
          "mailnews.headers.sendUserAgent" = true;
          "mailnews.headers.useMinimalUserAgent" = true;

          /*
          * ADDRESS BOOK **
          */
          /*
            9130: Address book collection [SETUP-FEATURE]
          * Disable Thunderbird internal address book email collection
          * Consider using CardBook extension instead (https://addons.thunderbird.net/addon/cardbook/)
          * [SETTING] Preferences > Composition > Addressing > Automatically add outgoing e-mail addresses...
          * [SETTING][CARDBOOK] CardBook > Preferences > Email > Collect Outgoing Email **
          */
          "mail.collect_addressbook" = "jsaddrbook://history.sqlite";
          "mail.collect_email_address_outgoing" = false;
          /*
            9131: Only use email addresses, without their Display Names [CARDBOOK] [SETUP-FEATURE]
          * By default, CardBook extension incorporates contacts display names in addresses fields.
          * This could leak sensitive information to all recipients.
          * [SETTING][CARDBOOK] CardBook > Preferences > Email > Sending Emails > Only use email addresses... **
          */
          "extensions.cardbook.useOnlyEmail" = true;

          /*
            ** [SECTION 9200]: EMAIL COMPOSITION (ENCODING / FORMAT / VIEW)
             Options that relate to composition, formatting and viewing email
          **
          */

          /*
          * ENCODING **
          */
          /*
            9205: Avoid information leakage in reply header
          * Reply header may contain sensitive information about system locale (date and/or language)
          * 0=no header
          * 1="<author> wrote:" (see `reply_header_authorwrotesingle` below)
          * 2="On <date> <author> wrote:" (see `reply_header_ondateauthorwrote` below [DEFAULT])
          * 3="<author> wrote On <date>:" (see `reply_header_authorwroteondate` below`)
          * 4=user specified (you may use below tokens to forge your own format [DISCOURAGED]) **
          */
          "mailnews.reply_header_type" = 1;
          "mailnews.reply_header_authorwrotesingle" = "#1 wrote:";
          "mailnews.reply_header_ondateauthorwrote" = "On #2 #3, #1 wrote:";
          "mailnews.reply_header_authorwroteondate" = "#1 wrote on #2 #3:";
          /*
            9206: Prevent spellchecking dictionary leakage through Content-Language header
          * [1] https://bugzilla.mozilla.org/show_bug.cgi?id=1370217 **
          */
          "mail.suppress_content_language" = true;
          /*
            9207: Sanitize Date header to convert date to UTC and round to closest minute
          * [1] https://bugzilla.mozilla.org/show_bug.cgi?id=1603359 **
          */
          "mail.sanitize_date_header" = true;

          /*
          * COMPOSITION **
          */
          /*
            9210: Check spelling before sending
          * [1] https://bugzilla.mozilla.org/show_bug.cgi?id=667133 **
          */
          "mail.SpellCheckBeforeSend" = false;
          /*
            9212: Compose email in plaintext unless expressly overridden
          * Sometimes HTML is useful especially when used with Markdown Here
          * [SETTING] Account Settings > Composition & Addressing > Composition > Compose messages in HTML format
          * NOTE: Holding down shift when you click on "Write" will bypass
          * [1] http://kb.mozillazine.org/Plain_text_e-mail_%28Thunderbird%29
          * [2] https://support.mozilla.org/en-US/questions/1004181
          * [3] https://markdown-here.com **
          */
          "mail.html_compose" = false;
          "mail.identity.default.compose_html" = false;
          /*
            9213: Send only plaintext email by default
          * You should only use HTML email if you need it (see [1])
          * [SETTING] Composition > Composition > Sending Format
          * Email that is HTML should also have plaintext multipart for plain text users.
          * 0=auto (default, send only plain text if the message is free of any rich formatting
            or inserted elements. Otherwise send both a HTML part and plain text alternative part)
          * 1=plain text (only send a plain text part, losing any rich formatting or inserted elements)
          * 2=HTML (only send a HTML part)
          * 3=both (send both the HTML part and the plain text alternative part)
          * [1] https://drewdevault.com/2016/04/11/Please-use-text-plain-for-emails.html **
          */
          "mail.default_send_format" = 0;
          /*
            9214: What classes can process incoming data. [SETUP-FEATURE]
          * (0=All classes (default), 1=Don't display HTML, 2=Don't display HTML and inline images,
          * 3=Don't display HTML, inline images and some other uncommon types, 100=Use a hard coded list)
          * In the past this has mitigated a vulnerability CVE-2008-0304 (rare)
          * [1] https://www.mozilla.org/en-US/security/advisories/mfsa2008-12/
          * [2] https://bugzilla.mozilla.org/show_bug.cgi?id=677905 **
          */
          "mailnews.display.disallow_mime_handlers" = 3;
          /*
            9215: How to display HTML parts of a message body
          * (0=Display the HTML normally (default), 1=Convert it to text and then back again
          * 2=Display the HTML source, 3=Sanitize the HTML, 4=Display all body parts)
          * (in trunk builds later than 2011-07-23)
          * [1] https://bugzilla.mozilla.org/show_bug.cgi?id=602718
          * [2] https://hg.mozilla.org/comm-central/rev/c1ef44a22eb2
          * [3] https://www.bucksch.org/1/projects/mozilla/108153/ **
          */
          "mailnews.display.html_as" = 3;
          "mail.html_sanitize.drop_conditional_css" = true; ## [DEFAULT: true]
          /*
            9216: Prefer to view as plaintext or HTML [SETUP-FEATURE]
          * true=Display a message as plain text when there is both a HTML and a plain
          * text version of a message body
          * false=Display a message as HTML when there is both a HTML and a plain text
          * version of a message body. (default) **
          */
          "mailnews.display.prefer_plaintext" = false;
          /*
            9217: Inline attachments [SETUP-FEATURE]
          * true=Show inlinable attachments (text, images, messages) after the message.
          * false=Do not display any attachments with the message **
          */
          "mail.inline_attachments" = false;
          "mail.inline_attachments.text" = false;
          /*
            9218: Big attachment warning
          * [1] https://support.mozilla.org/en-US/questions/1081046
          * [2] http://forums.mozillazine.org/viewtopic.php?f=39&t=2949521
          */
          "mail.compose.big_attachments.notify" = true; ## [DEFAULT: true]
          /*
          9219: Set big attachment size to warn at
          */
          "mail.compose.big_attachments.threshold_kb" = 9220; ## [DEFAULT: 5120]
          "mailnews.message_warning_size" = 20971520; ## [DEFAULT: 20971520]
          /*
          9220: Set public recipients number from which BCC is advised **
          */
          "mail.compose.warn_public_recipients.threshold" = 15; ## [DEFAULT: 15]
          /*
          9221: Show an alert if the warning above has not been addressed **
          */
          "mail.compose.warn_public_recipients.aggressive" = true;
          /*
            9222: Disable link previews
          * [SETTING] Composition > Composition > Add link previews when pasting URLs **
          */
          "mail.compose.add_link_preview" = false; ## [DEFAULT: false]

          /*
          * VIEW **
          */
          /*
            9230: Disable JavaScript
          * NOTE: JavaScript is already disabled in message content.
          * [1] https://developer.mozilla.org/en-US/docs/Mozilla/Thunderbird/Releases/3
          * [2] https://stackoverflow.com/questions/3054315/is-javascript-supported-in-an-email-message
          * **
          */
          "javascript.enabled" = true;
          /*
            9231: Disable media source extensions
          * [1] https://www.ghacks.net/2014/05/10/enable-media-source-extensions-firefox **
          */
          "media.mediasource.enabled" = false;
          /*
          9232: Disable hardware decoding support **
          */
          "media.hardware-video-decoding.enabled" = false;
          /*
            9233: Default image permissions
          * 1=Allow all images to load, regardless of origin. (Default),
          * 2=Block all images from loading.
          * 3=Prevent third-party images from loading
          * [1] http://kb.mozillazine.org/Permissions.default.image **
          */
          "permissions.default.image" = 2;
          /*
            9240: Builtin phishing/scamming detection
          * NOTE: These preferences are enabled by default and should not usually be touched.
          * [1] https://searchfox.org/comm-central/source/mail/modules/PhishingDetector.jsm **
          */
          "mail.phishing.detection.enabled" = true;
          "mail.phishing.detection.disallow_form_actions" = true;
          "mail.phishing.detection.ipaddresses" = true;
          "mail.phishing.detection.mismatched_hosts" = true;
          /*
            9250: Disable remote content loading
          * [SETTING] Privacy & Security > Privacy > Mail content > Allow remote content in messages **
          */
          "mailnews.message_display.disable_remote_image" = true; ## [DEFAULT: true]

          /*
            ** [SECTION 9300]: OTHER THUNDERBIRD COMPONENTS (CHAT / CALENDAR / RSS)
             Options that relate to other Thunderbird components such as the chat client, calendar and RSS)
          **
          */

          /*
          * CHAT **
          */
          /*
          9301: Disable chat functionality [SETUP-FEATURE] **
          */
          "mail.chat.enabled" = false;
          /*
          9302: Disable logging of group chats **
          */
          "purple.logging.log_chats" = false;
          /*
          9303: Disable logging of 1 to 1 conversations **
          */
          "purple.logging.log_ims" = false;
          /*
          9304: Disable logging of system messages **
          */
          "purple.logging.log_system" = false;
          /*
          9305: Disable typing notifications **
          */
          "purple.conversations.im.send_typing" = false;
          /*
            9306: When chat is enabled, do not connect to accounts automatically
          * 0=Do not connect / show the account manager,
          * 1=Connect automatically. (Default) **
          */
          "messenger.startup.action" = 0;
          /*
          9307: When chat is enabled, do not report idle status **
          */
          "messenger.status.reportIdle" = false;
          /*
          9308: Disable chat desktop notifications **
          */
          "mail.chat.show_desktop_notifications" = true;
          /*
            9309: Decide how much information will be shown in chat notifications
          * 0=Show all info (sender, chat message message preview),
          * 1=Show sender's info only (not message preview),
          * 2=No info (fill dummy values). **
          */
          "mail.chat.notification_info" = 2;

          /*
          * CALENDAR **
          */
          /*
            9312: Set calendar timezone to avoid system detection [SETUP-INSTALL]
          * By default, extensive system detection would be performed to find user's current timezone.
          * Setting this preference to "UTC" should disable it.
          * You may also directly set it to your timezone, i.e. "Pacific/Fakaofo"
          * [SETTING] Calendar > Calendar > Timezone **
          */
          "calendar.timezone.local" = "America/Chicago"; ## [DEFAULT: ""]
          /*
          9313: Disable calendar service performing event "extraction" from email content **
          */
          "calendar.extract.service.enabled" = true; ## [DEFAULT: false]

          /*
          * RSS **
          */
          /*
            * These features don't actually do anything as they aren't implemented
           * [1] https://searchfox.org/comm-esr102/source/mail/base/content/mailWindowOverlay.js#1082
           * [2] https://bugzilla.mozilla.org/show_bug.cgi?id=458606#c9
          /* 9320: What classes can process incoming data.
           * (0=All classes (default), 1=Don't display HTML, 2=Don't display HTML and inline images,
           * 3=Don't display HTML, inline images and some other uncommon types, 100=Use a hard coded list)
           * [1] https://www.privacy-handbuch.de/handbuch_31j.htm
          "rss.display.disallow_mime_handlers" = 3;
          /* 9321: How to display HTML parts of a message body
           * (0=Display the HTML normally (default), 1=Convert it to text and then back again
           * 2=Display the HTML source, 3=Sanitize the HTML, 4=Display all body parts)
           * (in trunk builds later than 2011-07-23)
           * [1] https://bugzilla.mozilla.org/show_bug.cgi?id=602718
           * [2] https://hg.mozilla.org/comm-central/rev/c1ef44a22eb2
           * [3] https://www.bucksch.org/1/projects/mozilla/108153/
          "rss.display.html_as" = 1;
          /* 9322: Prefer to view as plaintext or HTML
           * true=Display a message as plain text when there is both a HTML and a plain
           * text version of a message body
           * false=Display a message as HTML when there is both a HTML and a plain text
           * version of a message body. (default)
          "rss.display.prefer_plaintext" = true;
          *
          */
          /*
            9323: Feed message display (summary or web page), on open.
          * Action on double click or enter in threadpane for a feed message.
          * 0=open content-base url in new window, 1=open summary in new window,
          * 2=toggle load summary and content-base url in message pane,
          * 3=load content-base url in browser
          * [1] http://forums.mozillazine.org/viewtopic.php?f=39&t=2502335 **
          */
          "rss.show.content-base" = 3;
          /*
            9324: Feed message display (summary or web page), on select.
          * 0=global override, load web page, 1=global override, load summary,
          * 2=use default feed folder setting from Subscribe dialog; if no setting default to 1 **
          */
          "rss.show.summary" = 1;
          /*
            9325: Feed message additional web page display.
          * 0=no action, 1=load web page in default browser, on select **
          */
          "rss.message.loadWebPageOnSelect" = 0;

          /*
            ** [SECTION 9400]: THUNDERBIRD ENCRYPTION (OPENPGP / GNUPG)
             Options that relate to e-mail encryption in Thunderbird.
             [1] https://wiki.mozilla.org/Thunderbird:OpenPGP
             [2] https://support.mozilla.org/kb/openpgp-thunderbird-howto-and-faq
          **
          */

          /*
          * OPENPGP **
          */
          /*
          9400: disable OpenPGP "encryption is possible" reminder **
          */
          "mail.openpgp.remind_encryption_possible" = false; ## [TB102+]

          /*
          * GNUPG **
          */
          /*
            9409: Allow the use of external GnuPG
          * Whenever RNP fails to decrypt a message, Thunderbird will tray against system GnuPG
          * [1] https://wiki.mozilla.org/Thunderbird:OpenPGP:Smartcards#Allow_the_use_of_external_GnuPG **
          */
          "mail.openpgp.allow_external_gnupg" = true; ## [HIDDEN PREF]

          /*
            ** [SECTION 9999]: DEPRECATED / REMOVED / LEGACY / RENAMED
             Documentation denoted as [-]. Items deprecated prior to FF91 have been archived at [1]
             [1] https://github.com/arkenfox/user.js/issues/123
          **
          */
          /*
             ESR102.x still uses all the following prefs
          NOTE: replace the * with a slash in the line above to re-enable active ones
          FF103
          2801: delete cookies and site data on exit - replaced by sanitizeOnShutdown* (2810)
          0=keep until they expire (default), 2=keep until you close Thunderbird
          [-] https://bugzilla.mozilla.org/buglist.cgi?bug_id=1681493,1681495,1681498,1759665,1764761
          "network.cookie.lifetimePolicy" = 2;
          6012: disable SHA-1 certificates
          [-] https://bugzilla.mozilla.org/1766687
          "security.pki.sha1_enforcement_level" = 1; ## [DEFAULT: 1]
          FF114
          2816: set cache to clear on exit [FF96+]
          NOTE: We already disable disk cache (1001) and clear on exit (2811) which is more robust
          [1] https://bugzilla.mozilla.org/1671182
          [-] https://bugzilla.mozilla.org/1821651
          "privacy.clearsitedata.cache.enabled" = true;
          4505: experimental RFP [FF91+]
          [-] https://bugzilla.mozilla.org/1824235
          "privacy.resistFingerprinting.testGranularityMask" = 0;
          5017: disable Form Autofill heuristics
          Heuristics controls Form Autofill on forms without @autocomplete attributes
          [-] https://bugzilla.mozilla.org/1829670
          "extensions.formautofill.heuristics.enabled" = false; ## [FF55+]
          FF115
          7001: disable offline cache (appCache)
          NOTE: appCache storage capability was removed in FF90
          [-] https://bugzilla.mozilla.org/1677718
          "browser.cache.offline.enable" = false;
          **
          */
        };
      };
    };
  };

  # accounts.email.accounts.rbm = {
  #   thunderbird = {
  #     enable = true;
  #     profiles = ["main"];
  #   };
  # };
}
