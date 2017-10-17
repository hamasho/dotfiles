(define custom-activate-default-im-name? #t)
(define custom-preserved-default-im-name 'google-cgiapi-jp)
(define default-im-name 'google-cgiapi-jp)
(define enabled-im-list '(byeoru latin elatin m17n-sr-kbd m17n-iu-phonetic m17n-tai-sonla-kbd m17n-ne-rom m17n-ne-trad m17n-da-post m17n-ua-kbd m17n-cs-kbd m17n-am-sera m17n-cmc-kbd m17n-hy-kbd m17n-en-ispell m17n-be-kbd m17n-yi-yivo m17n-sd-inscript m17n-ii-phonetic m17n-fr-azerty m17n-mai-inscript m17n-sk-kbd m17n-th-kesmanee m17n-th-tis820 m17n-th-pattachote m17n-km-yannis m17n-te-inscript m17n-te-itrans m17n-te-apple m17n-te-rts m17n-te-pothana m17n-te-sarala m17n-ka-kbd m17n-he-kbd m17n-cr-western m17n-el-kbd m17n-bo-tcrc m17n-bo-wylie m17n-bo-ewts m17n-lo-kbd m17n-lo-lrt m17n-sa-IAST m17n-sa-harvard-kyoto m17n-sa-itrans m17n-ko-han2 m17n-ko-romaja m17n-ps-phonetic m17n-pa-anmollipi m17n-pa-itrans m17n-pa-jhelum m17n-pa-phonetic m17n-pa-inscript m17n-ath-phonetic m17n-ur-phonetic m17n-vi-vni m17n-vi-nomtelex m17n-vi-nomvni m17n-vi-han m17n-vi-tcvn m17n-vi-viqr m17n-vi-telex m17n-uz-kbd m17n-grc-mizuochi m17n-ks-inscript m17n-ks-kbd m17n-ug-kbd m17n-hr-kbd m17n-ru-kbd m17n-ru-phonetic m17n-ru-yawerty m17n-ru-translit m17n-ar-kbd m17n-ar-translit m17n-oj-phonetic m17n-eo-x-sistemo m17n-eo-h-fundamente m17n-eo-q-sistemo m17n-eo-h-sistemo m17n-eo-vi-sistemo m17n-eo-plena m17n-nsk-phonetic m17n-zh-cangjie m17n-zh-quick m17n-zh-tonepy-gb m17n-zh-py-gb m17n-zh-pinyin-vi m17n-zh-tonepy-b5 m17n-zh-py-b5 m17n-zh-tonepy m17n-zh-bopomofo m17n-zh-pinyin m17n-zh-py m17n-my-kbd m17n-fa-isiri m17n-dv-phonetic m17n-bn-inscript m17n-bn-probhat m17n-bn-unijoy m17n-bn-itrans m17n-bn-disha m17n-bla-phonetic m17n-hi-itrans m17n-hi-phonetic m17n-hi-vedmata m17n-hi-inscript m17n-hi-typewriter m17n-hi-remington m17n-sv-post m17n-mr-phonetic m17n-mr-inscript m17n-mr-itrans m17n-ta-lk-renganathan m17n-ta-tamil99 m17n-ta-phonetic m17n-ta-vutam m17n-ta-typewriter m17n-ta-itrans m17n-ta-inscript m17n-or-inscript m17n-or-itrans m17n-or-phonetic m17n-ja-anthy m17n-ja-trycode m17n-ja-tcode m17n-kn-typewriter m17n-kn-inscript m17n-kn-itrans m17n-kn-kgp m17n-gu-itrans m17n-gu-phonetic m17n-gu-inscript m17n-ml-swanalekha m17n-ml-inscript m17n-ml-itrans m17n-ml-mozhi m17n-ml-remington m17n-kk-kbd m17n-kk-arabic m17n-as-itrans m17n-as-phonetic m17n-as-inscript m17n-si-singlish m17n-si-sumihiri m17n-si-samanala m17n-si-transliteration m17n-si-phonetic-dynamic m17n-si-wijesekera m17n-latn1-pre m17n-ssymbol m17n-latn-pre m17n-unicode m17n-math-latex m17n-rfc1345 m17n-syrc-phonetic m17n-latn-post m17n-lsymbol zm wb86 py pyunihan pinyin-big5 viqr ipa-x-sampa look ajax-ime social-ime google-cgiapi-jp baidu-olime-jp))
(define enable-im-switch? #f)
(define switch-im-key '("<Control> "))
(define switch-im-key? (make-key-predicate '("<Control> ")))
(define switch-im-skip-direct-im? #f)
(define enable-im-toggle? #f)
(define toggle-im-key '("<Control> "))
(define toggle-im-key? (make-key-predicate '("<Control> ")))
(define toggle-im-alt-im 'direct)
(define uim-color 'uim-color-uim)
(define candidate-window-style 'vertical)
(define candidate-window-position 'caret)
(define enable-lazy-loading? #t)
(define bridge-show-input-state? #f)
(define bridge-show-with? 'time)
(define bridge-show-input-state-time-length 3)
