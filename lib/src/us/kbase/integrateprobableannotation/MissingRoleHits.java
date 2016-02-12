
package us.kbase.integrateprobableannotation;

import java.util.HashMap;
import java.util.List;
import java.util.Map;
import javax.annotation.Generated;
import com.fasterxml.jackson.annotation.JsonAnyGetter;
import com.fasterxml.jackson.annotation.JsonAnySetter;
import com.fasterxml.jackson.annotation.JsonInclude;
import com.fasterxml.jackson.annotation.JsonProperty;
import com.fasterxml.jackson.annotation.JsonPropertyOrder;


/**
 * <p>Original spec-file type: missingRoleHits</p>
 * 
 * 
 */
@JsonInclude(JsonInclude.Include.NON_NULL)
@Generated("com.googlecode.jsonschema2pojo")
@JsonPropertyOrder({
    "missingRoles"
})
public class MissingRoleHits {

    @JsonProperty("missingRoles")
    private List<MissingRolesData> missingRoles;
    private Map<String, Object> additionalProperties = new HashMap<String, Object>();

    @JsonProperty("missingRoles")
    public List<MissingRolesData> getMissingRoles() {
        return missingRoles;
    }

    @JsonProperty("missingRoles")
    public void setMissingRoles(List<MissingRolesData> missingRoles) {
        this.missingRoles = missingRoles;
    }

    public MissingRoleHits withMissingRoles(List<MissingRolesData> missingRoles) {
        this.missingRoles = missingRoles;
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
        return ((((("MissingRoleHits"+" [missingRoles=")+ missingRoles)+", additionalProperties=")+ additionalProperties)+"]");
    }

}
