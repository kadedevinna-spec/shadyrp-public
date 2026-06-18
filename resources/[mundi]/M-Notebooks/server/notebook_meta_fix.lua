-- Temporary test command for v-inventory notebook metadata

RegisterCommand('givenotebookmeta', function(source, args)
    local src = source
    local notebookId = tonumber(args[1])

    if not notebookId then
        print('[M-Notebooks Fix] Missing notebook id.')
        return
    end

    exports['rsg-inventory']:AddItem(src, 'notebook', 1, nil, {
        notebookId = notebookId,
        notebook_id = notebookId,
        id = notebookId,
        description = 'Notebook #' .. tostring(notebookId)
    })

    print('[M-Notebooks Fix] Gave notebook with metadata notebookId:', notebookId)
end)