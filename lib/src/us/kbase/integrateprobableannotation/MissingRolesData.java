
package us.kbase.integrateprobableannotation;

import java.util.HashMap;
import java.util.Map;
import javax.annotation.Generated;
import com.fasterxml.jackson.annotation.JsonAnyGetter;
import com.fasterxml.jackson.annotation.JsonAnySetter;
import com.fasterxml.jackson.annotation.JsonInclude;
import com.fasterxml.jackson.annotation.JsonProperty;
import com.fasterxml.jackson.annotation.JsonPropertyOrder;


/**
 * <p>Original spec-file type: MissingRolesData</p>
 * 
 * 
 */
@JsonInclude(JsonInclude.Include.NON_NULL)
@Generated("com.googlecode.jsonschema2pojo")
@JsonPropertyOrder({
    "role_description",
    "perc_identity",
    "genome_hits",
    "hit_location",
    "blast_score",
    "protein_sequence"
})
public class MissingRolesData {

    @JsonProperty("role_description")
    private String roleDescription;
    @JsonProperty("perc_identity")
    private Double percIdentity;
    @JsonProperty("genome_hits")
    private Long genomeHits;
    @JsonProperty("hit_location")
    private String hitLocation;
    @JsonProperty("blast_score")
    private String blastScore;
    @JsonProperty("protein_sequence")
    private String proteinSequence;
    private Map<String, Object> additionalProperties = new HashMap<String, Object>();

    @JsonProperty("role_description")
    public String getRoleDescription() {
        return roleDescription;
    }

    @JsonProperty("role_description")
    public void setRoleDescription(String roleDescription) {
        this.roleDescription = roleDescription;
    }

    public MissingRolesData withRoleDescription(String roleDescription) {
        this.roleDescription = roleDescription;
        return this;
    }

    @JsonProperty("perc_identity")
    public Double getPercIdentity() {
        return percIdentity;
    }

    @JsonProperty("perc_identity")
    public void setPercIdentity(Double percIdentity) {
        this.percIdentity = percIdentity;
    }

    public MissingRolesData withPercIdentity(Double percIdentity) {
        this.percIdentity = percIdentity;
        return this;
    }

    @JsonProperty("genome_hits")
    public Long getGenomeHits() {
        return genomeHits;
    }

    @JsonProperty("genome_hits")
    public void setGenomeHits(Long genomeHits) {
        this.genomeHits = genomeHits;
    }

    public MissingRolesData withGenomeHits(Long genomeHits) {
        this.genomeHits = genomeHits;
        return this;
    }

    @JsonProperty("hit_location")
    public String getHitLocation() {
        return hitLocation;
    }

    @JsonProperty("hit_location")
    public void setHitLocation(String hitLocation) {
        this.hitLocation = hitLocation;
    }

    public MissingRolesData withHitLocation(String hitLocation) {
        this.hitLocation = hitLocation;
        return this;
    }

    @JsonProperty("blast_score")
    public String getBlastScore() {
        return blastScore;
    }

    @JsonProperty("blast_score")
    public void setBlastScore(String blastScore) {
        this.blastScore = blastScore;
    }

    public MissingRolesData withBlastScore(String blastScore) {
        this.blastScore = blastScore;
        return this;
    }

    @JsonProperty("protein_sequence")
    public String getProteinSequence() {
        return proteinSequence;
    }

    @JsonProperty("protein_sequence")
    public void setProteinSequence(String proteinSequence) {
        this.proteinSequence = proteinSequence;
    }

    public MissingRolesData withProteinSequence(String proteinSequence) {
        this.proteinSequence = proteinSequence;
        return this;
    }

    @JsonAnyGetter
    public Map<String, Object> getAdditionalProperties() {
        return this.additionalProperties;
    }

    @JsonAnySetter
    public void setAdditionalProperties(String name, Object value) {
        this.additionalProperties.put(name, value);
    }

    @Override
    public String toString() {
        return ((((((((((((((("MissingRolesData"+" [roleDescription=")+ roleDescription)+", percIdentity=")+ percIdentity)+", genomeHits=")+ genomeHits)+", hitLocation=")+ hitLocation)+", blastScore=")+ blastScore)+", proteinSequence=")+ proteinSequence)+", additionalProperties=")+ additionalProperties)+"]");
    }

}
