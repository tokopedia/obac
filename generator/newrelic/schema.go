package newrelic

const NerdStorageWriteDocumentSchema = `
mutation nerdStorageWriteDocument($doc: NerdStorageDocument!, $scope: NerdStorageScopeInput!, $docID: String, $collection: String) {
  nerdStorageWriteDocument(
    scope: $scope
    collection: $collection
    documentId: $docID
    document: $doc
  )
}
`
