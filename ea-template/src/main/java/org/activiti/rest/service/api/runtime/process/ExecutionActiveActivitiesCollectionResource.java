/* Licensed under the Apache License, Version 2.0 (the "License");
 * you may not use this file except in compliance with the License.
 * You may obtain a copy of the License at
 * 
 *      http://www.apache.org/licenses/LICENSE-2.0
 * 
 * Unless required by applicable law or agreed to in writing, software
 * distributed under the License is distributed on an "AS IS" BASIS,
 * WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
 * See the License for the specific language governing permissions and
 * limitations under the License.
 */

package org.activiti.rest.service.api.runtime.process;


import java.util.List;

import org.activiti.engine.runtime.Execution;
import org.activiti.rest.common.api.ActivitiUtil;
import org.restlet.resource.Get;


/**
 * @author Frederik Heremans
 */
public class ExecutionActiveActivitiesCollectionResource extends ExecutionBaseResource {

  @Get
  public List<String> getActiveActivities() {
    if(!authenticate()) {
      return null;
    }
    Execution execution = getExecutionFromRequest();
    return ActivitiUtil.getRuntimeService().getActiveActivityIds(execution.getId());
  }
}
