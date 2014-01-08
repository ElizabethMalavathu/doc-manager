# Document.first.tags
# Document Load (1.0ms)  SELECT "documents".* FROM "documents" LIMIT 1
# Tag Load (12.7ms)  SELECT "tags".* FROM "tags" INNER JOIN "documents_tags" ON "tags"."id" = "documents_tags"."tag_id" WHERE "documents_tags"."document_id" = 1 
# irb(main):021:0> Collection.first.documents
# Collection Load (0.7ms)  SELECT "collections".* FROM "collections" LIMIT 1
# Document Load (3.2ms)  SELECT "documents".* FROM "documents" INNER JOIN "references" ON "documents"."id" = "references"."document_id" WHERE "references"."collection_id" = 1 

#  Collection.first.references
#  Collection Load (0.5ms)  SELECT "collections".* FROM "collections" LIMIT 1
#  Reference Load (0.4ms)  SELECT "references".* FROM "references" WHERE "references"."collection_id" = 1 

# {a: "b", foo: "Bar"} 
# duplicates = [] 
# duplicates << {original_id: ID, duplicate_id: DUP_ID}
# __________________________________________________
#Document.find( :original_id => ["count(*) > 1") 
 #original_id >1 = duplicate_id.

#SELECT Doc JOIN references ON Doc.id = reference.doc_id WHERE reference.class_id = ??
