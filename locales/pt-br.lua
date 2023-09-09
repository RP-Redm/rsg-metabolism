local Translations = {
error = {
    var = 'o texto vai aqui',
},
success = {
    var = 'o texto vai aqui',
},
primary = {
    var = 'o texto vai aqui',
},
menu = {
    var = 'o texto vai aqui',
},
commands = {
    var = 'o texto vai aqui',
},
progressbar = {
    var = 'o texto vai aqui',
},
}

if GetConvar('rsg_locale', 'en') == 'pt-br' then
    Lang = Locale:new({
        phrases = Translations,
        warnOnMissing = true,
        fallbackLang = Lang,
    })
end

-- Lang:t('error.no_item')
