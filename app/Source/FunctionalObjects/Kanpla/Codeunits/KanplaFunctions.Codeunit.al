codeunit 60000 "Kanpla Functions_EVAS"
{
    procedure GetCompanyIDsFromKanpla()
    var
        KanplaCompanyID: Record "Kanpla Company ID_EVAS";
        JsonListOfCompanyObjects: List of [JsonObject];
        CompanyIDsResponseArray: JsonArray;
        JsonCustomFieldsObject: JsonObject;
        JsonCompanyObject: JsonObject;
        CustomFieldsToken: JsonToken;
        ProjectIDToken: JsonToken;
        ItemIDToken: JsonToken;
        NameToken: JsonToken;
        ProjectIDText: Text;
        IDToken: JsonToken;
        EntryNo: Integer;
        ItemIDText: Text;
        NameText: Text;
        IDText: Text;
        i: Integer;
    begin
        CompanyIDsResponseArray := GetCompanyIDsFromKanplaAPIAsJsonArray();
        JsonListOfCompanyObjects := CreateListOfJsonObjectsFromJsonArray(CompanyIDsResponseArray);

        for i := 1 to JsonListOfCompanyObjects.Count do begin
            JsonListOfCompanyObjects.Get(i, JsonCompanyObject);
            JsonCompanyObject.Get('name', NameToken);
            NameToken.WriteTo(NameText);
            JsonCompanyObject.Get('id', IDToken);
            IDToken.WriteTo(IDText);
            JsonCompanyObject.Get('customFields', CustomFieldsToken);
            JsonCustomFieldsObject := CustomFieldsToken.AsObject();
            JsonCustomFieldsObject.Get('project_id', ProjectIDToken);
            ProjectIDToken.WriteTo(ProjectIDText);
            JsonCustomFieldsObject.Get('item_id', ItemIDToken);
            ItemIDToken.WriteTo(ItemIDText);

            EntryNo := 10000;
            KanplaCompanyID.Reset();
            if KanplaCompanyID.FindLast() then
                EntryNo := KanplaCompanyID."Entry No." + 10000;

            KanplaCompanyID.SetRange(ID, IDText);
            if not KanplaCompanyID.FindFirst() then begin
                KanplaCompanyID.Init();
                KanplaCompanyID.Validate("Entry No.", EntryNo);
                KanplaCompanyID.Validate(Name, DelChr(NameText, '=', '"'));
                KanplaCompanyID.Validate(ID, DelChr(IDText, '=', '"'));
                Evaluate(KanplaCompanyID."Project ID", DelChr(ProjectIDText, '=', '"'));
                Evaluate(KanplaCompanyID."Item ID", DelChr(ItemIDText, '=', '"'));
                KanplaCompanyID.Insert(true);
            end;
        end;
    end;

    local procedure GetCompanyIDsFromKanplaAPIAsJsonArray(): JsonArray
    var
        HttpRequestMessage: HttpRequestMessage;
        Response: HttpResponseMessage;
        JsonResponseToken: JsonToken;
        RequestHeaders: HttpHeaders;
        ResponseText: Text;
        Client: HttpClient;
        RequestURI: Text;
    begin
        RequestURI := 'https://kanpla-billing-924sk0e.ew.gateway.dev/getInvoiceBlocks';

        HttpRequestMessage.GetHeaders(RequestHeaders);
        RequestHeaders.Add('Accept', '*/*');
        RequestHeaders.Add('Accept-Encoding', 'gzip, deflate, br');
        RequestHeaders.Add('Connection', 'Keep-alive');
        RequestHeaders.Add('x-api-key', 'AIzaSyC-GXN6HUTNZXYjX4HZRprm9Y4xfiZMceI');

        HttpRequestMessage.SetRequestUri(RequestURI);
        HttpRequestMessage.Method('Get');

        Client.Send(HttpRequestMessage, Response);
        Response.Content.ReadAs(ResponseText);
        JsonResponseToken.ReadFrom(ResponseText);

        exit(JsonResponseToken.AsArray());
    end;

    local procedure CreateListOfJsonObjectsFromJsonArray(CompanyIDsResponseArray: JsonArray): List of [JsonObject]
    var
        JsonListOfCompanyObjects: List of [JsonObject];
        JsonCompanyObject: JsonObject;
        JsonCompanyToken: JsonToken;
        i: Integer;
    begin
        for i := 0 to CompanyIDsResponseArray.Count - 1 do begin
            CompanyIDsResponseArray.Get(i, JsonCompanyToken);
            JsonCompanyObject := JsonCompanyToken.AsObject();
            JsonListOfCompanyObjects.Add(JsonCompanyObject);
        end;
        exit(JsonListOfCompanyObjects)
    end;

    procedure GetInvoicesFromCompanyID(CompanyID: Text[100]; StartingDate: Date; EndingDate: Date)
    var
        InvoiceStagingHeader: Record "Invoice Staging Header_EVAS";
        InvoiceStagingLine: Record "Invoice Staging Line_EVAS";
        KanplaCompanyID: Record "Kanpla Company ID_EVAS";
        HeaderField: Record Field;
        LineField: Record Field;
        HeaderRecordRef: RecordRef;
        HeaderIDFieldRef: FieldRef;
        LineRecordRef: RecordRef;
        HeaderFieldRef: FieldRef;
        LineNoFieldRef: FieldRef;
        LineFieldRef: FieldRef;
        JsonListOfInvoiceLineObjects: List of [JsonObject];
        JsonListOfInvoiceObjects: List of [JsonObject];
        JsonInvoiceLineObject: JsonObject;
        JsonInvoiceObject: JsonObject;
        JsonInvoiceArray: JsonArray;
        HeaderToken: JsonToken;
        LinesToken: JsonToken;
        LinesArray: JsonArray;
        LineToken: JsonToken;
        HeaderText: Text;
        LineNo: Integer;
        LineText: Text;
        Count: Integer;
        i: Integer;
        j: Integer;
    begin
        JsonInvoiceArray := GetInvoicesFromKanplaAPIAsJsonArray(CompanyID, StartingDate, EndingDate);
        JsonListOfInvoiceObjects := CreateListOfJsonObjectsFromJsonArray(JsonInvoiceArray);

        HeaderRecordRef.Open(Database::"Invoice Staging Header_EVAS");
        LineRecordRef.Open(Database::"Invoice Staging Line_EVAS");

        HeaderField.SetRange(TableNo, Database::"Invoice Staging Header_EVAS");
        HeaderField.SetFilter("No.", '<2000000');

        LineField.SetRange(TableNo, Database::"Invoice Staging Line_EVAS");
        LineField.SetFilter("No.", '<2000000');
        Count := JsonListOfInvoiceObjects.Count;

        for i := 1 to Count do begin
            JsonListOfInvoiceObjects.Get(i, JsonInvoiceObject);
            InvoiceStagingHeader.Init();

            if HeaderField.FindSet() then
                repeat
                    case HeaderField.FieldName of
                        'Project ID':
                            begin
                                HeaderFieldRef := HeaderRecordRef.Field(HeaderField."No.");
                                KanplaCompanyID.SetRange(ID, CompanyID);
                                if KanplaCompanyID.FindFirst() then
                                    SetValueBasedOnType(HeaderFieldRef, KanplaCompanyID."Project ID");
                            end;
                        'Item ID':
                            begin
                                HeaderFieldRef := HeaderRecordRef.Field(HeaderField."No.");
                                KanplaCompanyID.SetRange(ID, CompanyID);
                                if KanplaCompanyID.FindFirst() then
                                    SetValueBasedOnType(HeaderFieldRef, KanplaCompanyID."Item ID");
                            end;
                        'POS System':
                            begin
                                HeaderFieldRef := HeaderRecordRef.Field(HeaderField."No.");
                                SetValueBasedOnType(HeaderFieldRef, 'Kanpla');
                            end;
                        'Errors':
                            begin
                                HeaderFieldRef := HeaderRecordRef.Field(HeaderField."No.");
                                SetValueBasedOnType(HeaderFieldRef, 'false');
                            end;
                        else
                            if JsonInvoiceObject.Get(HeaderField.FieldName, HeaderToken) then begin
                                HeaderFieldRef := HeaderRecordRef.Field(HeaderField."No.");
                                HeaderToken.WriteTo(HeaderText);
                                HeaderText := DelChr(HeaderText, '=', '"');
                                SetValueBasedOnType(HeaderFieldRef, HeaderText);
                            end else begin
                                HeaderFieldRef := HeaderRecordRef.Field(HeaderField."No.");
                                SetValueBasedOnType(HeaderFieldRef, '');
                            end;
                    end;
                until HeaderField.Next() = 0;
            HeaderRecordRef.Insert(true);

            JsonInvoiceObject.Get('lines', LinesToken);
            LinesArray := LinesToken.AsArray();

            JsonListOfInvoiceLineObjects := CreateListOfJsonObjectsFromJsonArray(LinesArray);

            for j := 1 to JsonListOfInvoiceLineObjects.Count do begin
                JsonListOfInvoiceLineObjects.Get(j, JsonInvoiceLineObject);
                LineNo := 0;
                InvoiceStagingLine.Init();

                if LineField.FindSet() then
                    repeat
                        case LineField.FieldName of
                            'Line No.':
                                begin
                                    LineNoFieldRef := LineRecordRef.Field(6);
                                    LineNo := LineNoFieldRef.Value;
                                    if LineNo = 0 then
                                        LineNo := 10000
                                    else
                                        LineNo := LineNo + 10000;
                                    LineFieldRef := LineRecordRef.Field(LineField."No.");
                                    SetValueBasedOnType(LineFieldRef, LineNo);
                                end;
                            'Header ID':
                                begin
                                    LineFieldRef := LineRecordRef.Field(LineField."No.");
                                    HeaderIDFieldRef := HeaderRecordRef.Field(1);
                                    LineText := HeaderIDFieldRef.Value;
                                    SetValueBasedOnType(LineFieldRef, LineText);
                                end;
                            else begin
                                JsonInvoiceLineObject.Get(LineField.FieldName, LineToken);
                                LineFieldRef := LineRecordRef.Field(LineField."No.");
                                LineToken.WriteTo(LineText);
                                LineText := DelChr(LineText, '=', '"');
                                SetValueBasedOnType(LineFieldRef, LineText);
                            end;
                        end;
                    until LineField.Next() = 0;
                LineRecordRef.Insert(true);
            end;
        end;
        HeaderRecordRef.Close();
        LineRecordRef.Close();
    end;

    local procedure SetValueBasedOnType(FieldRef: FieldRef; ValueText: Variant)
    var
        DateTime: DateTime;
        VariantToText: Text;
        TextToInt: Integer;
        Date: Date;
    begin
        case FieldRef.Type of
            FieldType::DateTime:
                begin
                    Evaluate(DateTime, ValueText);
                    FieldRef.Value := DateTime;
                end;
            FieldType::Date:
                begin
                    Evaluate(Date, ValueText);
                    FieldRef.Value := Date;
                end;
            FieldType::Boolean:
                FieldRef.Value := false;
            FieldType::Integer:
                if ValueText.IsText then begin
                    Evaluate(VariantToText, ValueText);
                    if VariantToText = 'null' then
                        FieldRef.Value := 0
                    else begin
                        Evaluate(TextToInt, VariantToText);
                        FieldRef.Value := TextToInt;
                    end;
                end else
                    FieldRef.Value := ValueText;
            else
                FieldRef.Value := ValueText;
        end;
    end;

    local procedure GetInvoicesFromKanplaAPIAsJsonArray(CompanyID: Text[100]; StartingDate: Date; EndingDate: Date): JsonArray
    var
        JsonInvoiceObject: JsonObject;
        Response: HttpResponseMessage;
        JsonResponseToken: JsonToken;
        ContentHeaders: HttpHeaders;
        Request: HttpRequestMessage;
        RequestHeaders: HttpHeaders;
        OrderLinesToken: JsonToken;
        JsonInvoiceAsText: Text;
        Content: HttpContent;
        Client: HttpClient;
        ResponseText: Text;
        RequestURI: Text;
    begin
        RequestURI := 'https://kanpla-billing-924sk0e.ew.gateway.dev/getInvoice';

        JsonInvoiceObject.Add('settingsId', CompanyID);
        JsonInvoiceObject.Add('fromDate', Format(StartingDate, 0, '<Day,2>-<Month,2>-<Year4>'));
        JsonInvoiceObject.Add('toDate', Format(EndingDate, 0, '<Day,2>-<Month,2>-<Year4>'));

        JsonInvoiceObject.WriteTo(JsonInvoiceAsText);

        Content.WriteFrom(JsonInvoiceAsText);

        Content.GetHeaders(ContentHeaders);
        ContentHeaders.Clear();
        ContentHeaders.Add('Content-Type', 'application/json');

        Request.GetHeaders(RequestHeaders);
        RequestHeaders.Add('Accept', '*/*');
        RequestHeaders.Add('Accept-Encoding', 'gzip, deflate, br');
        RequestHeaders.Add('Connection', 'Keep-alive');
        RequestHeaders.Add('x-api-key', 'AIzaSyC-GXN6HUTNZXYjX4HZRprm9Y4xfiZMceI');

        Request.Content := Content;
        Request.SetRequestUri(RequestURI);
        Request.Method('Post');

        Client.Send(Request, Response);
        Response.Content.ReadAs(ResponseText);

        JsonResponseToken.ReadFrom(ResponseText);

        JsonInvoiceObject := JsonResponseToken.AsObject();
        JsonInvoiceObject.Get('orderLines', OrderLinesToken);

        exit(OrderLinesToken.AsArray());
    end;
}