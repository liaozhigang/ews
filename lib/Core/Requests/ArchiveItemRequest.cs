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






    /// <summary>
    /// Represents a ArchiveItem request.
    /// </summary>
    class ArchiveItemRequest : MultiResponseServiceRequest<ArchiveItemResponse>
    {
        /// <summary>
        /// Source folder id
        /// </summary>
        /* private */ FolderId sourceFolderId;

        /// <summary>
        /// Items
        /// </summary>
        /* private */ ItemIdWrapperList ids = new ItemIdWrapperList();

        /// <summary>
        /// Initializes a new instance of the <see cref="ArchiveItemRequest"/> class.
        /// </summary>
        /// <param name="service">The service.</param>
        /// <param name="errorHandlingMode"> Indicates how errors should be handled.</param>
        ArchiveItemRequest(ExchangeService service, ServiceErrorHandling errorHandlingMode)
            : super(service, errorHandlingMode)
        {
        }

        /// <summary>
        /// Validates request.
        /// </summary>
@override
        void Validate()
        {
            EwsUtilities.ValidateParam(this.sourceFolderId, "SourceFolderId");
            this.sourceFolderId.Validate(this.Service.RequestedServerVersion);
        }

        /// <summary>
        /// Creates the service response.
        /// </summary>
        /// <param name="service">The service.</param>
        /// <param name="responseIndex">Index of the response.</param>
        /// <returns>Service response.</returns>
@override
        ArchiveItemResponse CreateServiceResponse(ExchangeService service, int responseIndex)
        {
            return new ArchiveItemResponse();
        }

        /// <summary>
        /// Gets or sets the Archive source folder id.
        /// </summary>
        /// <value>The archive source folder id.</value>
 FolderId SourceFolderId
        {
            get { return this.sourceFolderId; }
            set { this.sourceFolderId = value; }
        }

        /// <summary>
        /// Gets the item ids.
        /// </summary>
        /// <value>The item ids.</value>
        ItemIdWrapperList Ids
        {
            get { return this.ids; }
        }

        /// <summary>
        /// Gets the expected response message count.
        /// </summary>
        /// <returns>Number of expected response messages.</returns>
@override
        int GetExpectedResponseMessageCount()
        {
            return this.ids.Count;
        }

        /// <summary>
        /// Gets the name of the XML element.
        /// </summary>
        /// <returns>XML element name,</returns>
@override
        String GetXmlElementName()
        {
            return XmlElementNames.ArchiveItem;
        }

        /// <summary>
        /// Gets the name of the response XML element.
        /// </summary>
        /// <returns>XML element name,</returns>
@override
        String GetResponseXmlElementName()
        {
            return XmlElementNames.ArchiveItemResponse;
        }

        /// <summary>
        /// Gets the name of the response message XML element.
        /// </summary>
        /// <returns>XML element name,</returns>
@override
        String GetResponseMessageXmlElementName()
        {
            return XmlElementNames.ArchiveItemResponseMessage;
        }

        /// <summary>
        /// Gets the request version.
        /// </summary>
        /// <returns>Earliest Exchange version in which this request is supported.</returns>
@override
        ExchangeVersion GetMinimumRequiredServerVersion()
        {
            return ExchangeVersion.Exchange2013;
        }

        /// <summary>
        /// Writes XML elements.
        /// </summary>
        /// <param name="writer">The writer.</param>
@override
        void WriteElementsToXml(EwsServiceXmlWriter writer)
        {
            writer.WriteStartElement(XmlNamespace.Messages, XmlElementNames.ArchiveSourceFolderId);
            this.SourceFolderId.WriteToXml(writer);
            writer.WriteEndElement();

            this.WriteIdsToXml(writer);
        }

        /// <summary>
        /// Writes the ids as XML.
        /// </summary>
        /// <param name="writer">The writer.</param>
        void WriteIdsToXml(EwsServiceXmlWriter writer)
        {
            this.Ids.WriteToXml(
                writer,
                XmlNamespace.Messages,
                XmlElementNames.ItemIds);
        }
    }
