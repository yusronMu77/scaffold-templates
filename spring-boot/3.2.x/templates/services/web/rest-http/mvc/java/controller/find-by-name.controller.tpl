
    // Spliced by insert_after - see mvc/jig.yaml (WithSearchByName). @PathVariable, not
    // @RequestParam, so this doesn't also need to splice a new import into the file it lands in.
    @GetMapping("/search/{name}")
    public List<{{ .EntityName }}> findByName(@PathVariable String name) {
        return service.findByName(name);
    }
