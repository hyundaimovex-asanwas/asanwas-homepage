var AJAX = {
    Send: function(url, data, async, func, error) {
        if (async == null) async = false; // true:비동기, false:동기

        var json;
        $.ajax({
            async: async,
            type: 'POST',
            url: url,
            data: '{"inputContent":' + (data != null ? '"' + BASE64.Encode(JSON.stringify(data)) + '"' : null) + '}',
            contentType: 'application/json; charset=utf-8',
            dataType: 'json',
            success: function(result) {
                json = result;
                if (!json.success) {
                    if (json.msg == "LOGOUT") {
                        alert("로그아웃 되었습니다.");
                        location.href = "/default.html";
                    }
                }

                if (async)
                    func(json);
            },
            error: function(result) {
                if (async) {
                    error(result);
                }
                else {
                    if (!STR.IsNullOrEmpty(result.msg))
                        alert(result.msg);
                }
            }
        });

        if (!async)
            return json;
    },

    ParamAdd: function(data, name, value, type, direct, size) {
        //파라미터 만들기
        if (value == null) value = "";
        if (type == null) type = "VarChar";
        if (direct == null) direct = "Input";
        if (size == null) size = "0";

        var row = { "NAME": name, "TYPE": type, "DIRECTION": direct, "SIZE": size, "VALUE": value }
        data.push(row);
    },

    Serialize: function(data) {
        // Parameter Json 문자열 처리
        if (data != null) {
            if (data.hasOwnProperty("PARAMS")) {
                data.PARAMS = JSON.stringify(data.PARAMS);
            }
        }
        return data;
    },

    MultiSerialize: function(data) {
        // Parameter Json 문자열 처리 - Multi
        if (data != null) {
            for (var c = 0; c < data.length; c++) {
                if (data[c].hasOwnProperty("PARAMS")) {
                    data[c].PARAMS = JSON.stringify(data[c].PARAMS);
                }
                data[c] = JSON.stringify(data[c]);
            }
        }
        return data;
    },

    PublicKey: function(data) {
    return AJAX.Send("/Mobile/model/Ajax_Service.svc/PublicKey", data);
    },

    Login: function(data) {
    return AJAX.Send("/Mobile/model/Ajax_Service.svc/Login", data);
    },

    Logout: function() {
    return AJAX.Send("/Mobile/model/Ajax_Service.svc/Logout");
    },

    CheckUser: function() {
    return AJAX.Send("/Mobile/model/Ajax_Service.svc/CheckUser");
    },

    Select: function(data, async, func, error) {
        // Select (Json 리턴)
    return AJAX.Send("/Mobile/model/Ajax_Service.svc/Select", AJAX.Serialize(data), async, func, error);
    },

    Execute: function(data) {
        // Execute
    return AJAX.Send("/Mobile/model/Ajax_Service.svc/Execute", AJAX.Serialize(data));
    },

    Save: function(data) {
        // Save
    return AJAX.Send("/Mobile/model/Ajax_Service.svc/Save", AJAX.Serialize(data));
    },

    SaveOutput: function(data) {
        // Save
    return AJAX.Send("/Mobile/model/Ajax_Service.svc/SaveOutput", AJAX.Serialize(data));
    },

    MultiSelect: function(data) {
        // Multi Select
    return AJAX.Send("/Mobile/model/Ajax_Service.svc/MultiSelect", AJAX.MultiSerialize(data));
    },

    MultiSave: function(data, async, func, error) {
        // Multi Save
        if (async) {
            // 비동기
            AJAX.Send("/Mobile/model/Ajax_Service.svc/MultiSave", AJAX.MultiSerialize(data), true, func, error);
        }
        else {
            // 동기
            return AJAX.Send("/Mobile/model/Ajax_Service.svc/MultiSave", AJAX.MultiSerialize(data));
        }
    },

    FileList: function(data) {
    return AJAX.Send("/Mobile/model/Ajax_Service.svc/FileList", data, false, false);
    },

    FileUpload: function(provider, path, info, file, func, error) {
        var data = file.substr(file.indexOf('base64') + 7);

        $.ajax({
            async: false,
            type: 'POST',
            url: '/Mobile/model/Ajax_Service.svc/FileUpload',
            xhr: provider,
            contentType: 'application/json; charset=utf-8',
            dataType: 'json',
            success: function(result) {
                func(result);
            },
            error: function(result) {
                error(result);
            },
            data: '{"path": "' + path + '", "name": "' + info.name + '", "size": "' + info.size + '", "type": "' + info.type + '", "data": "' + data + '"}'
        });
    },

    RandomString: function(bit) {
        var chars = "0123456789ABCDEFGHIJKLMNOPQRSTUVWXTZabcdefghiklmnopqrstuvwxy~!@#$%^&*-_+=";
        var string_length = bit / 8;
        var randomstring = '';
        for (var i = 0; i < string_length; i++) {
            var rnum = Math.floor(Math.random() * chars.length);
            randomstring += chars.substring(rnum, rnum + 1);
        }
        return randomstring;
    }
}
