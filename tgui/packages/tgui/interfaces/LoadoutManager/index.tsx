import { useState } from 'react';
import {
  Box,
  Button,
  Flex,
  LabeledList,
  Section,
  Stack,
  Tabs,
} from 'tgui-core/components';

import { useBackend } from '../../backend';
import { Window } from '../../layouts';
import { NameInputModal } from './NameInputModal';
import {
  LoadoutItemData,
  LoadoutListData,
  LoadoutManagerData,
  LoadoutTabData,
} from './Types';

const LoadoutItem = (props: LoadoutItemData) => {
  const { act } = useBackend();
  const { loadout } = props;

  return (
    <Box>
      <LabeledList.Item
        labelColor="white"
        buttons={
          <>
            <Button
              icon="arrow-up"
              onClick={() =>
                act('edit_loadout_position', {
                  direction: 'up',
                  loadout_name: loadout.name,
                  loadout_job: loadout.job,
                })
              }
            />
            <Button
              icon="arrow-down"
              onClick={() =>
                act('edit_loadout_position', {
                  direction: 'down',
                  loadout_name: loadout.name,
                  loadout_job: loadout.job,
                })
              }
            />
            <Button
              onClick={() => {
                act('selectLoadout', {
                  loadout_name: loadout.name,
                  loadout_job: loadout.job,
                });
              }}
            >
              Select Loadout
            </Button>
          </>
        }
        label={loadout.name}
      />
    </Box>
  );
};

const LoadoutList = (props: LoadoutListData) => {
  const { loadout_list } = props;
  return (
    <Stack.Item>
      <Section height={23} fill scrollable>
        <LabeledList>
          {loadout_list.map((loadout_visible) => {
            return (
              <LoadoutItem
                key={loadout_visible.name}
                loadout={loadout_visible}
              />
            );
          })}
        </LabeledList>
      </Section>
    </Stack.Item>
  );
};

const JobTabs = (props: LoadoutTabData) => {
  const { job, setJob } = props;
  return (
    <Section>
      <Flex>
        <Flex.Item grow={1}>
          <div> </div>
        </Flex.Item>
        <Flex.Item>
          <Tabs>
            <Tabs.Tab
              selected={job === 'Squad Marine'}
              onClick={() => setJob('Squad Marine')}
            >
              Squad Marine
            </Tabs.Tab>
            <Tabs.Tab
              selected={job === 'Squad Robot'}
              onClick={() => setJob('Squad Robot')}
            >
              Squad Robot
            </Tabs.Tab>
            <Tabs.Tab
              selected={job === 'Squad Engineer'}
              onClick={() => setJob('Squad Engineer')}
            >
              Squad Engineer
            </Tabs.Tab>
            <Tabs.Tab
              selected={job === 'Squad Corpsman'}
              onClick={() => setJob('Squad Corpsman')}
            >
              Squad Corpsman
            </Tabs.Tab>
            <Tabs.Tab
              selected={job === 'Squad Smartgunner'}
              onClick={() => setJob('Squad Smartgunner')}
            >
              Squad Smartgunner
            </Tabs.Tab>
            <Tabs.Tab
              selected={job === 'Squad Leader'}
              onClick={() => setJob('Squad Leader')}
            >
              Squad Leader
            </Tabs.Tab>
            <Tabs.Tab
              selected={job === 'Field Commander'}
              onClick={() => setJob('Field Commander')}
            >
              Field Commander
            </Tabs.Tab>
            <Tabs.Tab
              selected={job === 'Synthetic'}
              onClick={() => setJob('Synthetic')}
            >
              Synthetic
            </Tabs.Tab>
          </Tabs>
        </Flex.Item>
        <Flex.Item grow={1}>
          <div> </div>
        </Flex.Item>
      </Flex>
    </Section>
  );
};

export const LoadoutManager = (props) => {
  const { act, data } = useBackend<LoadoutManagerData>();
  const { loadout_list } = data;

  const [job, setJob] = useState('Squad Marine');
  const [saveNewLoadout, setSaveNewLoadout] = useState(false);
  const [importNewLoadout, setImportNewLoadout] = useState(false);

  return (
    <Window title="Loadout Manager" width={800} height={400}>
      <Window.Content>
        <Stack vertical>
          <JobTabs job={job} setJob={setJob} />
          <LoadoutList
            loadout_list={loadout_list.filter((loadout) => loadout.job === job)}
          />
          <Flex>
            <Flex.Item grow={1}>
              <div> </div>
            </Flex.Item>
            <Flex.Item>
              <Button onClick={() => setSaveNewLoadout(true)}>
                Save your equipped loadout
              </Button>
            </Flex.Item>
            <Flex.Item grow={1}>
              <div> </div>
            </Flex.Item>
            <Flex.Item>
              <Button onClick={() => setImportNewLoadout(true)}>
                Import Loadout
              </Button>
            </Flex.Item>
            <Flex.Item grow={1}>
              <div> </div>
            </Flex.Item>
          </Flex>
        </Stack>
        {saveNewLoadout && (
          <NameInputModal
            label="Name of the new Loadout"
            button_text="Save"
            onBack={() => setSaveNewLoadout(false)}
            onSubmit={(name) => {
              act('saveLoadout', {
                loadout_name: name,
                loadout_job: job,
              });
              setSaveNewLoadout(false);
            }}
          />
        )}
        {importNewLoadout && (
          <NameInputModal
            label="Format requested : ckey//job//name_of_loadout "
            button_text="Import the loadout"
            onBack={() => setImportNewLoadout(false)}
            onSubmit={(id) => {
              act('importLoadout', {
                loadout_id: id,
              });
              setImportNewLoadout(false);
            }}
          />
        )}
      </Window.Content>
    </Window>
  );
};
