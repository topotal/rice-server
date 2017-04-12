class ApplicationResource
  include JsonWorld::DSL

  title "Rice Server API v1"
  description "Rice Server API v1 interface document written in JSON Hyper Schema draft v4"

  property :recipes, links: true, type: RecipeResource
  link href: "https://xn--38j8bv87v8z2b18b", rel: "self"
end
