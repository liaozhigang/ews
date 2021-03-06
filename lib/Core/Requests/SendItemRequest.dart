/*
 * Exchange Web Services Managed API
 *
 * Copyright (c) Microsoft Corporation
 * All rights reserved.
 *
 * MIT License
 *
 * Permission is hereby granted, free of charge, to any person obtaining a copy of this
 * software and associated documentation files (the "Software"), to deal in the Software
 * without restriction, including without limitation the rights to use, copy, modify, merge,
 * publish, distribute, sublicense, and/or sell copies of the Software, and to permit persons
 * to whom the Software is furnished to do so, subject to the following conditions:
 *
 * The above copyright notice and this permission notice shall be included in all copies or
 * substantial portions of the Software.
 *
 * THE SOFTWARE IS PROVIDED *AS IS*, WITHOUT WARRANTY OF ANY KIND, EXPRESS OR IMPLIED,
 * INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY, FITNESS FOR A PARTICULAR
 * PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE
 * FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR
 * OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER
 * DEALINGS IN THE SOFTWARE.
 */

import 'package:ews/ComplexProperties/FolderId.dart';
import 'package:ews/Core/EwsServiceXmlWriter.dart';
import 'package:ews/Core/EwsUtilities.dart';
import 'package:ews/Core/ExchangeService.dart';
import 'package:ews/Core/Requests/MultiResponseServiceRequest.dart';
import 'package:ews/Core/Responses/ServiceResponse.dart';
import 'package:ews/Core/ServiceObjects/Items/Item.dart';
import 'package:ews/Core/XmlAttributeNames.dart';
import 'package:ews/Core/XmlElementNames.dart';
import 'package:ews/Enumerations/ExchangeVersion.dart';
import 'package:ews/Enumerations/ServiceErrorHandling.dart';
import 'package:ews/Enumerations/XmlNamespace.dart';

/// <summary>
/// Represents a SendItem request.
/// </summary>
class SendItemRequest extends MultiResponseServiceRequest<ServiceResponse> {
  Iterable<Item> _items;

  FolderId _savedCopyDestinationFolderId;

  /// <summary>
  /// Asserts the valid.
  /// </summary>
  @override
  void Validate() {
    super.Validate();
    EwsUtilities.ValidateParam(this.Items, "Items");

    if (this.SavedCopyDestinationFolderId != null) {
      this
          .SavedCopyDestinationFolderId
          .ValidateExchangeVersion(this.Service.RequestedServerVersion);
    }
  }

  /// <summary>
  /// Creates the service response.
  /// </summary>
  /// <param name="service">The service.</param>
  /// <param name="responseIndex">Index of the response.</param>
  /// <returns>Service response.</returns>
  @override
  ServiceResponse CreateServiceResponse(
      ExchangeService service, int responseIndex) {
    return new ServiceResponse();
  }

  /// <summary>
  /// Gets the expected response message count.
  /// </summary>
  /// <returns>Number of expected response messages.</returns>
  @override
  int GetExpectedResponseMessageCount() {
    return EwsUtilities.GetEnumeratedObjectCount(this.Items);
  }

  /// <summary>
  /// Gets the name of the XML element.
  /// </summary>
  /// <returns>XML element name,</returns>
  @override
  String GetXmlElementName() {
    return XmlElementNames.SendItem;
  }

  /// <summary>
  /// Gets the name of the response XML element.
  /// </summary>
  /// <returns>XML element name,</returns>
  @override
  String GetResponseXmlElementName() {
    return XmlElementNames.SendItemResponse;
  }

  /// <summary>
  /// Gets the name of the response message XML element.
  /// </summary>
  /// <returns>XML element name,</returns>
  @override
  String GetResponseMessageXmlElementName() {
    return XmlElementNames.SendItemResponseMessage;
  }

  /// <summary>
  /// Writes the attributes to XML.
  /// </summary>
  /// <param name="writer">The writer.</param>
  @override
  void WriteAttributesToXml(EwsServiceXmlWriter writer) {
    super.WriteAttributesToXml(writer);

    writer.WriteAttributeValue(XmlAttributeNames.SaveItemToFolder,
        this.SavedCopyDestinationFolderId != null);
  }

  /// <summary>
  /// Writes the elements to XML.
  /// </summary>
  /// <param name="writer">The writer.</param>
  @override
  void WriteElementsToXml(EwsServiceXmlWriter writer) {
    writer.WriteStartElement(XmlNamespace.Messages, XmlElementNames.ItemIds);

    for (Item item in this.Items) {
      item.Id.WriteToXml(writer, XmlElementNames.ItemId);
    }

    writer.WriteEndElement(); // ItemIds

    if (this.SavedCopyDestinationFolderId != null) {
      writer.WriteStartElement(
          XmlNamespace.Messages, XmlElementNames.SavedItemFolderId);
      this.SavedCopyDestinationFolderId.WriteToXmlElemenetName(writer);
      writer.WriteEndElement();
    }
  }

  /// <summary>
  /// Gets the request version.
  /// </summary>
  /// <returns>Earliest Exchange version in which this request is supported.</returns>
  @override
  ExchangeVersion GetMinimumRequiredServerVersion() {
    return ExchangeVersion.Exchange2007_SP1;
  }

  /// <summary>
  /// Initializes a new instance of the <see cref="SendItemRequest"/> class.
  /// </summary>
  /// <param name="service">The service.</param>
  /// <param name="errorHandlingMode"> Indicates how errors should be handled.</param>
  SendItemRequest(
      ExchangeService service, ServiceErrorHandling errorHandlingMode)
      : super(service, errorHandlingMode) {}

  /// <summary>
  /// Gets or sets the items.
  /// </summary>
  /// <value>The items.</value>
  Iterable<Item> get Items => this._items;

  set Items(Iterable<Item> value) => this._items = value;

  /// <summary>
  /// Gets or sets the saved copy destination folder id.
  /// </summary>
  /// <value>The saved copy destination folder id.</value>
  FolderId get SavedCopyDestinationFolderId =>
      this._savedCopyDestinationFolderId;

  set SavedCopyDestinationFolderId(FolderId value) =>
      this._savedCopyDestinationFolderId = value;
}
